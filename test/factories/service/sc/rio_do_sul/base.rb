FactoryGirl.define do
	factory :service_sc_rio_do_sul_base, class:  BrNfe::Service::SC::RioDoSul::Base do
		emitente  { FactoryGirl.build(:service_emitente) }
	end
end