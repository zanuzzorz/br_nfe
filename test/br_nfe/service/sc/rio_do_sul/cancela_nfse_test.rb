require 'test_helper'

describe BrNfe::Service::SC::RioDoSul::CancelaNfse do
	subject             { FactoryGirl.build(:service_sc_rio_do_sul_cancela_nfse, lote_rps: [rps]) }
	let(:rps)           { FactoryGirl.build(:br_nfe_rps, :completo, items: [item]) } 
	let(:xml)           { Nokogiri::XML(subject.xml_builder) } 
	let(:item)          { FactoryGirl.build(:service_item) }


	describe "xml_builder" do
		context "atributos nfse" do
			it "o atributo identificador deve estar presente se tiver o valor de identificador" do
				subject.identificador = 987654321
				xml.at('nfse/identificador').text.must_equal '987654321'
			end
			it "o atributo identificador não deve estar presente se não houver o valor de identificador" do
				subject.identificador = nil
				xml.at('nfse/identificador').must_be_nil
			end
		end

		context "atributos nfse/rps" do
			it "o atributo nro_recibo_provisorio deve estar presente se tiver o valor de rps.numero" do
				rps.numero = 987654321
				xml.at('nfse/rps/nro_recibo_provisorio').text.must_equal '987654321'
			end
			it "o atributo nro_recibo_provisorio não deve estar presente se não houver o valor de rps.numero" do
				rps.numero = nil
				xml.at('nfse/rps/nro_recibo_provisorio').must_be_nil
			end

			it "serie_recibo_provisorio deve ter o valor da serie do rps" do
				rps.serie = '2'
				xml.at('nfse/rps/serie_recibo_provisorio').text.must_equal '2'
			end
			it "serie_recibo_provisorio não deve estar presente se não houver o valor de rps.serie" do
				rps.serie = nil
				xml.at('nfse/rps/serie_recibo_provisorio').must_be_nil
			end

			it "data_emissao_recibo_provisorio deve ter o valor formatado para data com a data de emissão" do
				rps.data_emissao = DateTime.parse('12/08/2014 04:05:06')
				xml.at('nfse/rps/data_emissao_recibo_provisorio').text.must_equal '2014-08-12'
			end
			it "data_emissao_recibo_provisorio não deve estar presente se não houver o valor de rps.serie" do
				rps.data_emissao = nil
				xml.at('nfse/rps/data_emissao_recibo_provisorio').must_be_nil
			end

			it "hora_emissao_recibo_provisori deve ter o valor formatado para data com a data de emissão" do
				rps.data_emissao = DateTime.parse('12/08/2014 04:05:06')
				xml.at('nfse/rps/hora_emissao_recibo_provisorio').text.must_equal '04:05:06'
			end
			it "hora_emissao_recibo_provisori não deve estar presente se não houver o valor de rps.serie" do
				rps.data_emissao = nil
				xml.at('nfse/rps/hora_emissao_recibo_provisori').must_be_nil
			end
		end

		context "atributos nfse/nf" do
			it "deve ter o numero da NFS-e" do
				subject.nfe_number = '123456789'
				xml.at('nfse/nf/numero').text.must_equal '123456789'
			end

			it "deve setar o valor do atributo 'situacao' para 'C'" do
				xml.at('nfse/nf/situacao').text.must_equal 'C'
			end

			it "valor_total deve ter o valor total da NFS-e" do
				rps.valor_liquido = '500.0'
				xml.at('nfse/nf/valor_total').text.must_equal '500.0'
			end

			it "valor_desconto deve ter o valor da soma do desconto_incondicionado e desconto_condicionado" do
				rps.desconto_condicionado = '15.0'
				rps.desconto_incondicionado = '5.0'
				xml.at('nfse/nf/valor_desconto').text.must_equal '20.0'
			end
			it "valor_desconto não deve estar presente se não houver os valores nos descontos" do
				rps.desconto_condicionado = nil
				rps.desconto_incondicionado = nil
				xml.at('nfse/nf/valor_desconto').must_be_nil
			end

			it "valor_ir deve ter o valor do IR" do
				rps.valor_ir = '30'
				xml.at('nfse/nf/valor_ir').text.must_equal '30.0'
			end
			it "valor_ir não deve estar presente se não houver o valor do IR" do
				rps.valor_ir = nil
				xml.at('nfse/nf/valor_ir').must_be_nil
			end

			it "valor_inss deve ter o valor do INSS" do
				rps.valor_inss = '152.3'
				xml.at('nfse/nf/valor_inss').text.must_equal '152.3'
			end
			it "valor_inss não deve estar presente se não houver o valor do INSS" do
				rps.valor_inss = nil
				xml.at('nfse/nf/valor_inss').must_be_nil
			end

			it "valor_contribuicao_social deve ter o valor da Contribuição Social" do
				rps.valor_csll = '13.77'
				xml.at('nfse/nf/valor_contribuicao_social').text.must_equal '13.77'
			end
			it "valor_contribuicao_social não deve estar presente se não houver o valor da Contribuição Social" do
				rps.valor_csll = nil
				xml.at('nfse/nf/valor_contribuicao_social').must_be_nil
			end

			it "valor_rps deve ter o valor RPS (Retenções    da Previdência  Social)" do
				rps.outras_retencoes = '1'
				xml.at('nfse/nf/valor_rps').text.must_equal '1.0'
			end
			it "valor_rps não deve estar presente se não houver o valor do INSS" do
				rps.outras_retencoes = nil
				xml.at('nfse/nf/valor_rps').must_be_nil
			end

			it "valor_pis deve ter o valor do PIS" do
				rps.valor_pis = '2365.99'
				xml.at('nfse/nf/valor_pis').text.must_equal '2365.99'
			end
			it "valor_pis não deve estar presente se não houver o valor do PIS" do
				rps.valor_pis = nil
				xml.at('nfse/nf/valor_pis').must_be_nil
			end

			it "valor_cofins deve ter o valor do CONFINS" do
				rps.valor_cofins = '850'
				xml.at('nfse/nf/valor_cofins').text.must_equal '850.0'
			end
			it "valor_cofins não deve estar presente se não houver o valor do CONFINS" do
				rps.valor_cofins = nil
				xml.at('nfse/nf/valor_cofins').must_be_nil
			end

			it "observacao deve ter as observações da NFS-e" do
				rps.description = 'Observações da NFS-e.'
				xml.at('nfse/nf/observacao').text.must_equal 'Observações da NFS-e.'
			end
			it "observacao não deve estar presente se não houver observações" do
				rps.description = nil
				xml.at('nfse/nf/observacao').must_be_nil
			end
		end

		context "atributos nfse/prestador" do
			it "cpfcnpj deve ter o valor CPF/CNPJ do prestador" do
				subject.emitente.cpf_cnpj = '92675492000133'
				xml.at('nfse/prestador/cpfcnpj').text.must_equal '92675492000133'
			end

			it "deve ter o valor Código da cidade onde o emissor está estabelecido, junto à Receita Federal" do
				subject.emitente.endereco.codigotom = '8055'
				xml.at('nfse/prestador/cidade').text.must_equal '8055'
			end
			it "cidade não deve estar presente se não houver o codigo da cidade" do
				subject.emitente.endereco.codigotom  = nil
				xml.at('nfse/prestador/cidade').must_be_nil
			end
		end

		context "atributos nfse/tomador" do
			it "deve ter o valor endereco_informado do tomador" do
				subject.endereco_informado = 'N'
				xml.at('nfse/tomador/endereco_informado').text.must_equal 'N'
			end
			it "não deve estar presente se não houver o endereco_informado" do
				subject.endereco_informado  = nil
				xml.at('nfse/prestador/endereco_informado').must_be_nil
			end

			it "deve setar o campo 'tipo' com 'J' e o campo 'cpfcnpj' com o CNPJ se for pessoa Jurídica" do
				rps.destinatario.cpf_cnpj = '95881115000149'
				xml.at('nfse/tomador/tipo').text.must_equal 'J'
				xml.at('nfse/tomador/cpfcnpj').text.must_equal '95881115000149'
			end
			it "deve setar o campo 'tipo' com 'F' e o campo 'cpfcnpj' com o CPF se for pessoa Física" do
				rps.destinatario.cpf_cnpj = '84817644265'
				xml.at('nfse/tomador/tipo').text.must_equal 'F'
				xml.at('nfse/tomador/cpfcnpj').text.must_equal '84817644265'
			end

			it "deve ter o valor inscricao_estadual do tomador" do
				rps.destinatario.inscricao_estadual = '123456'
				xml.at('nfse/tomador/ie').text.must_equal '123456'
			end
			it "não deve estar presente se não houver o inscricao_estadual" do
				rps.destinatario.inscricao_estadual  = nil
				xml.at('nfse/prestador/ie').must_be_nil
			end

			it "deve ter o valor nome_razao_social do tomador" do
				rps.destinatario.razao_social = 'MINHA EMPRESA LTDA'
				xml.at('nfse/tomador/nome_razao_social').text.must_equal 'MINHA EMPRESA LTDA'
			end

			it "deve ter o valor nome_fantasia do tomador" do
				rps.destinatario.nome_fantasia = 'EMPRESA'
				xml.at('nfse/tomador/sobrenome_nome_fantasia').text.must_equal 'EMPRESA'
			end
			it "não deve estar presente se não houver o nome_fantasia" do
				rps.destinatario.nome_fantasia  = nil
				xml.at('nfse/prestador/sobrenome_nome_fantasia').must_be_nil
			end
		end

		context "atributos nfse/tomador (Endereço)" do
			it "deve ter o valor logradouro do tomador" do
				rps.destinatario.endereco.logradouro = 'RUA TESTE'
				xml.at('nfse/tomador/logradouro').text.must_equal 'RUA TESTE'
			end
			it "não deve estar presente se não houver o logradouro" do
				rps.destinatario.endereco.logradouro  = nil
				xml.at('nfse/prestador/logradouro').must_be_nil
			end

			it "deve ter o valor email do tomador" do
				rps.destinatario.email = 'tomador@teste.com'
				xml.at('nfse/tomador/email').text.must_equal 'tomador@teste.com'
			end
			it "não deve estar presente se não houver o email" do
				rps.destinatario.email  = nil
				xml.at('nfse/prestador/email').must_be_nil
			end

			it "deve ter o valor numero do tomador" do
				rps.destinatario.endereco.numero = '156'
				xml.at('nfse/tomador/numero_residencia').text.must_equal '156'
			end
			it "não deve estar presente se não houver o numero" do
				rps.destinatario.endereco.numero  = nil
				xml.at('nfse/prestador/numero_residencia').must_be_nil
			end

			it "deve ter o valor complemento do tomador" do
				rps.destinatario.endereco.complemento = 'D'
				xml.at('nfse/tomador/complemento').text.must_equal 'D'
			end
			it "não deve estar presente se não houver o complemento" do
				rps.destinatario.endereco.complemento  = nil
				xml.at('nfse/prestador/complemento').must_be_nil
			end

			it "deve ter o valor ponto_referencia do tomador" do
				rps.destinatario.endereco.ponto_referencia = 'Próximo ao mercado do Jão'
				xml.at('nfse/tomador/ponto_referencia').text.must_equal 'Próximo ao mercado do Jão'
			end
			it "não deve estar presente se não houver o ponto_referencia" do
				rps.destinatario.endereco.ponto_referencia  = nil
				xml.at('nfse/prestador/ponto_referencia').must_be_nil
			end

			it "deve ter o valor bairro do tomador" do
				rps.destinatario.endereco.bairro = 'CENTRO'
				xml.at('nfse/tomador/bairro').text.must_equal 'CENTRO'
			end
			it "não deve estar presente se não houver o bairro" do
				rps.destinatario.endereco.bairro  = nil
				xml.at('nfse/prestador/bairro').must_be_nil
			end

			it "deve ter o valor codigotom do tomador" do
				rps.destinatario.endereco.codigotom = '8081'
				xml.at('nfse/tomador/cidade').text.must_equal '8081'
			end
			it "não deve estar presente se não houver o codigotom" do
				rps.destinatario.endereco.codigotom  = nil
				xml.at('nfse/prestador/cidade').must_be_nil
			end

			it "deve ter o valor cep do tomador" do
				rps.destinatario.endereco.cep = '99999999'
				xml.at('nfse/tomador/cep').text.must_equal '99999999'
			end
			it "não deve estar presente se não houver o cep" do
				rps.destinatario.endereco.cep  = nil
				xml.at('nfse/prestador/cep').must_be_nil
			end
		end

		context "atributos nfse/tomador (Contato)" do
			it "deve ter o valor fone_comercial do tomador" do
				rps.destinatario.ddd_fone_comercial = '49'
				rps.destinatario.fone_comercial = '39999999'
				xml.at('nfse/tomador/ddd_fone_comercial').text.must_equal '49'
				xml.at('nfse/tomador/fone_comercial').text.must_equal '39999999'
			end
			it "não deve estar presente se não houver o fone_comercial" do
				rps.destinatario.ddd_fone_comercial  = nil
				rps.destinatario.fone_comercial  = nil
				xml.at('nfse/prestador/ddd_fone_comercial').must_be_nil			
				xml.at('nfse/prestador/fone_comercial').must_be_nil
			end
			
			it "deve ter o valor fone_residencial do tomador" do
				rps.destinatario.ddd_fone_residencial = '49'
				rps.destinatario.fone_residencial = '39999999'
				xml.at('nfse/tomador/ddd_fone_residencial').text.must_equal '49'
				xml.at('nfse/tomador/fone_residencial').text.must_equal '39999999'
			end
			it "não deve estar presente se não houver o fone_residencial" do
				rps.destinatario.ddd_fone_residencial  = nil
				rps.destinatario.fone_residencial  = nil
				xml.at('nfse/prestador/ddd_fone_residencial').must_be_nil			
				xml.at('nfse/prestador/fone_residencial').must_be_nil
			end

			it "deve ter o valor fone_residencial do tomador" do
				rps.destinatario.ddd_fone_residencial = '49'
				rps.destinatario.fone_residencial = '39999999'
				xml.at('nfse/tomador/ddd_fone_residencial').text.must_equal '49'
				xml.at('nfse/tomador/fone_residencial').text.must_equal '39999999'
			end
			it "não deve estar presente se não houver o fone_fax" do
				rps.destinatario.ddd_fone_fax  = nil
				rps.destinatario.fone_fax  = nil
				xml.at('nfse/prestador/ddd_fone_fax').must_be_nil			
				xml.at('nfse/prestador/fone_fax').must_be_nil
			end
		end

		context "atributos nfse/itens/lista" do
			let(:item_2) { FactoryGirl.build(:service_item, 
					tributa_municipio_prestador: 'S',
					codigo_local_prestacao_servico: '9090',
					unidade_codigo: '555',
					quantidade: 3,
					valor_unitario: '88.56',
					codigo_item_lista_servico: '123456',
					description: 'Item description 2',
					iss_aliquota: '0.005',
					cst: '1',
					valor_total: '547.8888',
				) } 
			it "o deve ter um atributo itens/lista para cada item de serviço com suas respectivas informações" do
				rps.items << item_2
				items = xml.at('nfse/itens').search('lista')
				
				items[0].at('tributa_municipio_prestador').text.must_equal ''
				items[0].at('codigo_local_prestacao_servico').text.must_equal ''
				items[0].at('unidade_codigo').text.must_equal ''
				items[0].at('unidade_quantidade').text.must_equal '2'
				items[0].at('unidade_valor_unitario').text.must_equal '100.0'
				items[0].at('codigo_item_lista_servico').text.must_equal '0107'
				items[0].at('descritivo').text.must_equal 'Item description'
				items[0].at('aliquota_item_lista_servico').text.must_equal '0.025'
				items[0].at('situacao_tributaria').text.must_equal '1'
				items[0].at('valor_tributavel').text.must_equal '200.0'
				items[0].at('valor_deducao').text.must_equal '70'
				items[0].at('valor_issrf').text.must_equal ''		

				items[1].at('tributa_municipio_prestador').text.must_equal 'S'
				items[1].at('codigo_local_prestacao_servico').text.must_equal '9090'
				items[1].at('unidade_codigo').text.must_equal '555'
				items[1].at('unidade_quantidade').text.must_equal '3'
				items[1].at('unidade_valor_unitario').text.must_equal '88.56'
				items[1].at('codigo_item_lista_servico').text.must_equal '123456'
				items[1].at('descritivo').text.must_equal 'Item description 2'
				items[1].at('aliquota_item_lista_servico').text.must_equal '0.005'
				items[1].at('situacao_tributaria').text.must_equal '1'
				items[1].at('valor_tributavel').text.must_equal '547.89'
				items[1].at('valor_deducao').text.must_equal '70'
				items[1].at('valor_issrf').text.must_equal ''
			end
		end	
	end
end