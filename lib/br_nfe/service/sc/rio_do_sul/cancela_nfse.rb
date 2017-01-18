module BrNfe
	module Service
		module SC
			module RioDoSul
				class CancelaNfse < BrNfe::Service::SC::RioDoSul::Base
					include BrNfe::Service::Concerns::Rules::CancelamentoNfs
					include BrNfe::Service::Concerns::Rules::RecepcaoLoteRps
					
					def xml_builder
						render_xml 'cancelamento', dir_path: "#{BrNfe.root}/lib/br_nfe/service/sc/rio_do_sul/xml"
					end					
				end
			end
		end
	end
end