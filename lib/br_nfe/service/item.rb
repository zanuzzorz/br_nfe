module BrNfe
	module Service
		class Item < BrNfe::ActiveModelBase
			
			# ID do código CNAE
			# Algumas cidades necessitam que esse ID seja passado
			# e normalmente é encontrado junto a documentação da mesma.
			#
			# <b>Tipo: </b> _Integer_
			attr_accessor :cnae_id

			# Código CNAE (Classificação Nacional de Atividades Econômicas)
			# Pode ser encontrado em  http://www.cnae.ibge.gov.br/
			# Tamanho de 8 caracteres
			#
			# <b>Tipo: </b> _String_
			attr_accessor :cnae_code

			# Descrição do serviço
			# Será utilizada apenas para as cidades que permitem adicionar mais de 1 item de
			#  serviço na mesma nota
			#
			# <b>Tipo: </b> _Text_
			attr_accessor :description


			# CST
			# Código da situação tributária
			#  onde apenas alguns municipios utilizam
			#
			# <b>Tipo: </b> _Text_
			attr_accessor :cst

			# Alíquota
			# Percentual de aliquota dividido por 100
			# Ex: se a aliquita for 7.5% então o valor setado no campo é 0.075
			#
			# <b>Tipo: </b> _Float_
			attr_accessor :iss_aliquota

			# Valor unitário do item
			# Refere-se ao valor separado de cada serviço prestado
			#
			# <b>Tipo: </b> _Float_
			attr_accessor :valor_unitario

			# Quantidade prestada de serviços do item
			#
			# <b>Tipo: </b> _Float_
			attr_accessor :quantidade

			# Valor total cobrado do item
			#
			# <b>Tipo: </b> _Float_
			attr_accessor :valor_total


			###########################################################################################

			# Código do subitem da lista de serviços, em conformidade com a Lei Complementar 116/2003. 
			#
			# <b>Tipo: </b> _Integer_
			attr_accessor :codigo_item_lista_servico


			# Esta tag serve para informar onde será recolhido o imposto e deve ser preenchida com 
			# "0" ou "N" quando NÃO TRIBUTAR P/ PRESTADOR e "1" ou "S" quando TRIBUTAR P/ PRESTADOR.
			#
			# <b>Type: </b> _Text_
			# <b>Size: </b> 1
			# <b>Default: </b> 0
			#
			attr_accessor :tributa_municipio_prestador 

			# Código da cidade onde o serviço foi prestado, junto à Receita Federal.
			#
			# <b>Type: </b> _Integer_
			# <b>Size: </b> 9
			#
			attr_accessor :codigo_local_prestacao_servico

			# Código das unidades de serviços pré cadastradas. <OPCIONAL>
			# OBS: Código sobre variações de Prefeitura para Prefeitura. O campo torna-se obrigatório a partir 
			# do momento em que o Município utiliza esta configuração.
			#
			# <b>Type: </b> _Integer_
			# <b>Size: </b> 9
			#
			attr_accessor :unidade_codigo

			
			def default_values
				{
					quantidade: 1.0,
				}
			end


			def valor_total
				@valor_total || (quantidade.to_f * valor_unitario.to_f)
			end
		end
	end
end