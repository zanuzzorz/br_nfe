require 'test_helper'

describe BrNfe::Service::Simpliss::V1::ConsultaSituacaoLoteRps do
	subject             { FactoryGirl.build(:service_simpliss_v1_consulta_situacao_lote_rps, emitente: emitente) }
	let(:emitente)      { FactoryGirl.build(:emitente) }

	it { must validate_presence_of(:protocolo) }

	describe "superclass" do
		it { subject.class.superclass.must_equal BrNfe::Service::Simpliss::V1::ConsultaLoteRps }
	end

	describe "#method_wsdl" do
		it { subject.method_wsdl.must_equal :consultar_situacao_lote_rps }
	end

	it "#response_path_module" do
		subject.response_path_module.must_equal BrNfe::Service::Response::Paths::V1::ServicoConsultarSituacaoLoteRpsResposta
	end

	it "#response_root_path" do
		subject.response_root_path.must_equal [:consultar_situacao_lote_rps_response]
	end

	it "#body_xml_path" do
		subject.body_xml_path.must_equal []
	end

	it "#soap_body_root_tag" do
		subject.soap_body_root_tag.must_equal 'ConsultarSituacaoLoteRps'
	end
	
	describe "Validação do XML através do XSD" do
		let(:schemas_dir) { BrNfe.root+'/test/br_nfe/service/simpliss/v1/xsd' }
				
		describe "Validações a partir do arquivo XSD" do
			it "Deve ser válido com 1 RPS com todas as informações preenchidas" do
				# Só assim para passar na validação XSD.
				# o XSD não consegue validar os namespaces pois estão declarados na
				# tag envelope.
				subject.stubs(:message_namespaces).returns({'xmlns' => "http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"})
				subject.stubs(:namespace_identifier).returns(nil)
				subject.stubs(:namespace_for_tags).returns(nil)
				subject.stubs(:namespace_for_signature).returns(nil)
				
				Dir.chdir(schemas_dir) do
					schema = Nokogiri::XML::Schema(IO.read('nfse_3.xsd'))
					document = Nokogiri::XML(subject.xml_builder)
					errors = schema.validate(document)
					errors.must_be_empty
				end
			end
		end
	end
end