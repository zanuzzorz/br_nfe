FactoryGirl.define do
	factory :service_sc_rio_do_sul_cancela_nfse, class:  BrNfe::Service::SC::RioDoSul::CancelaNfse do
		emitente  { FactoryGirl.build(:service_emitente) }
	end
end