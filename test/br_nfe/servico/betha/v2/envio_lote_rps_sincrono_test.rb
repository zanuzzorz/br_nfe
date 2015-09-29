require 'test_helper'

describe BrNfe::Servico::Betha::V2::EnvioLoteRpsSincrono do
	subject        { FactoryGirl.build(:br_nfe_servico_betha_v2_envio_lote_rps_sincrono, emitente: emitente) }
	let(:emitente) { FactoryGirl.build(:emitente) }
	
	describe "inheritance class" do
		it { subject.class.superclass.must_equal BrNfe::Servico::Betha::V2::RecepcaoLoteRps }
	end

	describe "validations" do
		it { must validate_presence_of(:numero_lote_rps) }
		it { must validate_presence_of(:certificado) }
		
		it "deve chamar o metodo validar_lote_rps" do
			subject.expects(:validar_lote_rps)
			subject.valid?
		end
	end

	describe "#method_wsdl" do
		it { subject.method_wsdl.must_equal :recepcionar_lote_rps_sincrono }
	end

	describe "#xml_builder" do
		it "não ocorre erro" do
			subject.stubs(:assinatura_xml).returns('<Signature>signed</Signature>')
			subject.xml_builder.class.must_equal Nokogiri::XML::Builder
		end
		it "estrutura" do
			subject.numero_lote_rps = 88966
			lote_rps_xml = Nokogiri::XML::Builder.new{|x| x.LoteRps 'valor loterps'}
			subject.expects(:lote_rps_xml).returns(lote_rps_xml)
			subject.expects(:assinatura_xml).with(lote_rps_xml.doc.root.to_s, '#lote88966').returns('<Signature>signed</Signature>')
			xml = subject.xml_builder.doc

			xml.namespaces.must_equal({"xmlns"=>"http://www.betha.com.br/e-nota-contribuinte-ws"})
			xml.remove_namespaces!

			xml.xpath('EnviarLoteRpsSincronoEnvio/LoteRps').first.text.must_equal 'valor loterps'
			xml.xpath('EnviarLoteRpsSincronoEnvio/Signature').first.text.must_equal 'signed'
		end
	end
	

end