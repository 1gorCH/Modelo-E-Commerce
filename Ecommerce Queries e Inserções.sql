show tables;
use ecommerce;

-- idClient, Fname, Minit, Lname, CPF, Address
insert into clients (Fname, Minit, Lname, CPF, Address)
            values('Maria','M','Silva', 12346789, 'rua silva de prata 29, Centro - Cidade das flores'),
				  ('Matheus','O','Pimentel', 987645321, 'rua alameda 289, Centro - Cidade das flores'),
                  ('Ricardo','F','Silva', 45678913, 'avenida alemda vinha 109, Centro - Ipiranga'),
				  ('Julia','S','França', 789123456, 'rua laranjeiras 861, Centro - Cidade das flores'),
                  ('Roberta','G','Assis', 98745631, 'avenida koller 19, Centro - Cidade das flores'),
				  ('Isabela','M','Cruz', 654789123, 'rua alemeda das flores 28, Centro - Ipiranga');
                  
-- idProduct, Pname, classification_kids boolean, categoy('Eletronico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
insert into product(Pname, Classification_kids, Category, Avaliation, size)
            values('Headset', false,'Eletrônico','4', null),
                  ('Barbie Elsa', true,'Brinquedos','3', null),
                  ('Body Carters', true,'Vestimenta','5', null),
                  ('Microfone Vedo - Youtuber', false,'Eletrônico','4', null),
                  ('Sofá retrátil', false,'Móveis','2', null),
                  ('Fire Stick Amazon', false,'Eletrônico','3', null);

select * from clients;
select * from product;

-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
delete from orders where idOrderClient in (19,20,21,24);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
            values (19, default,'compra via aplicativo', null, 1),
				   (20, default,'compra via aplicativo', 50, 0),
                   (21, 'Confirmado',null, null, 1),
                   (24, default,'compra via web site', 150, 0);
                   
select * from orders;
-- idPOproduct, idPOorder, poQuantity, poStatus
insert into productOrder (idPOproduct, idPOorder, PoQuantity, PoStatus)
          values (7,9,2,null),
				 (8,10,1,null),
                 (9,11,1,null);
                 
insert into productStorage (storageLocation, quantity)
          values ('Rio de Janeiro', 1000),
                 ('Rio de Janeiro', 500),
                 ('São Paulo', 10),
                 ('São Paulo', 100),
                 ('Brasília', 60);

-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location)
		  values (7,2,'RJ'),
				 (8,2,'RJ');

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact)
          values ('Almeida e filhos', 123456789123456, '21985474'),
				 ('Eletrônicos Silva', 487564879546546, '87465789'),
                 ('Eletrônicos Vilma', 987456321548754, '98745621');

-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity)
	      values (1,7,500),
                 (1,8,400),
                 (2,10,500),
                 (3,9,500),
                 (2,11,500);
 
 -- SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact)
          values ('Tech eletronics', null, 123456789321, null, 'Rio de Janeiro', 219946297),
                 ('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 219567895),
                 ('Kids Graça', null, 456875321564598, null, 'São Paulo', 1198657484);

-- idPseller, idProduct, prodQuantity
insert into productSeller (idPseller, idProduct, prodQuantity)
          values (1, 7, 80),
                 (2, 10, 10);

-- Consulta simples
select count(*) from clients c, orders
          where c.idClient = idOrderClient;
          
-- Recuperando dados dos pedidos e clientes que possuem pedidos.
select * from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname, ' ', Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

-- Recuperação de pedido com um produto associado
select c.idClient, c.Fname, o.idOrder, o.OrderStatus, p.idProduct, p.Pname
		  from clients c
		  inner join orders o ON c.idClient = o.idOrderClient
		  inner join productOrder po ON po.idPOorder = o.idOrder
          inner join product p ON p.idProduct = po.idPOproduct;

-- Recuperar quantos pedidos foram realizados pelos clientes
select c.idClient, Fname, count(*) as Number_of_orders from clients c
          inner join orders o ON c.idClient = o.idOrderClient
		  group by idClient;