module BrNfe
	module Service
		module SC
			module RioDoSul
				class Base < BrNfe::Service::Base

					# Utilizado para identificação do arquivo a ser processado, arquivos com mesmo identificador 
					# não serão processados mais de uma vez. <OPCIONAL>
					#
					# <b>Type: </b> _Text_
					# <b>Size: </b> 80
					#
					attr_accessor :identificador

					# Quando for do interesse que o endereço do tomador do serviço seja o informado no arquivo  xml, utilizar esta tag.
					# Sujeito a disponibilidade pelo município. 'S' ou '1' = SIM,  'N'  ou  '0' = NÃO. <OPCIONAL>
					#
					# <b>Type: </b> _Text_
					# <b>Size: </b> 1
					#
					attr_accessor :endereco_informado

					validates :identificador, length: {maximum: 80}, allow_blank: true

					# validates :ddd_fone_comercial, :ddd_fone_residencial, :ddd_fone_fax, length: {maximum: 3}, allow_blank: true
					# validates :fone_comercial, :fone_residencial, :fone_fax, length: {maximum: 9}, allow_blank: true
					

					def content_xml
						'<?xml version="1.0" encoding="ISO-8859-1"?>'+xml_builder
					end
				end
			end
		end
	end
end