FactoryGirl.define do
	factory :service_sc_rio_do_sul_recepcao_lote_rps, class:  BrNfe::Service::SC::RioDoSul::RecepcaoLoteRps do
		emitente  { FactoryGirl.build(:service_emitente) }
	end
end