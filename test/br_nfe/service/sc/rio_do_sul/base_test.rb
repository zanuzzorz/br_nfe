require 'test_helper'

describe BrNfe::Service::SC::RioDoSul::Base do
	subject { FactoryGirl.build(:service_sc_rio_do_sul_base) }

	describe "#content_xml" do
		it "deve concatenar o valro do metodo xml_builder com o cabeçalho padrão para XML" do
			subject.expects(:xml_builder).returns("<XMLBuilder>Value<XMLBuilder>")
			subject.content_xml.must_equal '<?xml version="1.0" encoding="ISO-8859-1"?><XMLBuilder>Value<XMLBuilder>'
		end
	end
end