require 'test_helper'

describe BrNfe::Service::RJ::RioDeJaneiro::V1::Base do
	subject             { FactoryGirl.build(:service_rj_rj_v1_base, emitente: emitente) }
	let(:rps)           { FactoryGirl.build(:br_nfe_rps, :completo) }
	let(:emitente)      { FactoryGirl.build(:service_emitente) }
	let(:intermediario) { FactoryGirl.build(:intermediario) }

	describe "inheritance class" do
		it { subject.class.superclass.must_equal BrNfe::Service::Base }
	end

	describe "#wsdl" do
		before do
			subject.env = :production
			subject.ibge_code_of_issuer_city = ''
		end

		# it "deve gerar um alerta se não for informado o codigo da cidade" do
		# 	assert_raises RuntimeError do
		# 		subject.wsdl
		# 	end
		# end

		# Rio de Janeiro - RJ
		it "se codigo da cidade emitente for 3304557 então deve pagar a URL de Rio de Janeiro - RJ" do
			subject.ibge_code_of_issuer_city = '3304557'
			subject.wsdl.must_equal 'https://notacarioca.rio.gov.br/WSNacional/nfse.asmx?wsdl'
		end

		it "se o env for de test deve enviar a requisição para o ambinete de homologação do Rio de Janeiro" do
			subject.ibge_code_of_issuer_city = '3304557'
			subject.env = :test
			subject.wsdl.must_equal 'https://homologacao.notacarioca.rio.gov.br/WSNacional/nfse.asmx?wsdl'
		end
	end

	describe "#canonicalization_method_algorithm" do
		it { subject.canonicalization_method_algorithm.must_equal 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315' }
	end

	describe "#message_namespaces" do
		it "deve ter um valor" do
			subject.message_namespaces.must_equal({'xmlns' => "http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd",})
		end
	end

	describe "#soap_namespaces" do
		it "deve conter os namespaces padrões mais o namespace da mensagem" do
			subject.soap_namespaces.must_equal({
				'xmlns:soapenv' => 'http://schemas.xmlsoap.org/soap/envelope/',
				'xmlns:ins0'    => 'http://www.w3.org/2000/09/xmldsig#',
				'xmlns:xsd'     => 'http://www.w3.org/2001/XMLSchema',
				'xmlns:xsi'     => 'http://www.w3.org/2001/XMLSchema-instance',
			})
		end
	end

	describe "#soap_body_root_tag" do
		it "por padrão deve dar um Raise pois é necessário que seja sobrescrito nas sublcasses" do
			assert_raises RuntimeError do
				subject.soap_body_root_tag
			end
		end
	end

	describe "#content_xml" do
		let(:expected_xml) do
			dados =  "<rootTag xmlns=\"http://notacarioca.rio.gov.br/\">"
			dados +=   '<inputXML>'
			dados +=     "<![CDATA[<xml>Builder</xml>]]>"
			dados +=   '</inputXML>'
			dados += "</rootTag>"
			dados
		end
		it "deve encapsular o XML de xml_builder em um CDATA mantendo o XML body no padrão de curitiba" do
			subject.expects(:soap_body_root_tag).returns('rootTag').twice	
			subject.expects(:xml_builder).returns('<xml>Builder</xml>')
			subject.content_xml.must_equal expected_xml
		end
		it "Caso o xml_builder já vier com a tag <?xml não deve inserir a tag novamnete" do
			subject.expects(:soap_body_root_tag).returns('rootTag').twice	
			subject.expects(:xml_builder).returns('<xml>Builder</xml>')
			subject.content_xml.must_equal expected_xml
		end
	end

end