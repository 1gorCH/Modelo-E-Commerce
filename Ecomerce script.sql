-- criação do banco de dados para o cenário de E-comerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
    idClient int primary key auto_increment,
    Fname varchar(15) not null,
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Adress varchar(50),
    Bdate date not null,
    constraint unique_cpf_client unique (CPF)
);
ALTER TABLE clients drop Bdate;
ALTER TABLE clients CHANGE Adress Address VARCHAR(50);
alter table clients auto_increment=1;
desc clients;

-- criar tabela produto
-- size equivale a dimensão do produto
create table product(
    idProduct int primary key auto_increment,
    Pname varchar(10) not null,
    Classification_kids bool default false,	
    Category Enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    Avaliation float default 0,
    Size varchar(10)
);
alter table product modify Pname varchar(50);
alter table product auto_increment=1;

-- criar tablea pagamento
create table payments(
   idclient int,
   idpayment int,
   TypePayment enum('Dinheiro', 'Cartão Crédito', 'Cartão Débito', 'Pix','Boleto'),
   Limitavailable float,
   primary key(idclient, idpayment)
);

-- criar tabela pedido
create table orders(
    idOrder int primary key auto_increment,
    idOrderClient int,
    OrderStatus enum('Cancelado', 'Em processamento', 'Confirmado', 'Entregue') default 'Em processamento',
    OrderDescription varchar(255),
    SendValue float default 10,
    paymentCash bool default false,
    idClient int,
    idPayment int,
    constraint fk_orders_payments foreign key (idClient, idPayment) references payments (idclient ,idpayment),
    constraint fk_orders_cient foreign key (idOrderClient) references clients (idClient)
    );
    
alter table orders auto_increment=1;
    
    -- criar tabela estoque
create table productStorage(
	idProdStorage int primary key auto_increment,
    StorageLocation varchar(255),
    Quantity int default 0
    );
alter table productStorage auto_increment=1;
    
    -- criar tabela fornecedor
create table supplier(
	idSupplier int primary key auto_increment,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    Contact char(11) not null,
    constraint unique_cnpj_supplier unique (CNPJ)
    );
    
alter table supplier auto_increment=1;
    -- criar tabela vendedor
create table seller(
	 idSeller int primary key auto_increment,
     SocialName varchar(255) not null,
     AbstName varchar(255),
     CNPJ char(15),
     CPF char(9),
     Location varchar(255),
     Contact char(11) not null,
     constraint unique_cnpj_seller unique (CNPJ),
     constraint unique_cpf_seller unique (CPF)
    );
    
alter table seller auto_increment=1;
    
create table productSeller(
	  idPseller int,
      idProduct int,
      ProdQuantity int default 1,
      primary key (idPseller, idProduct),
      constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
      constraint fk_producto_product foreign key (idProduct) references product(idProduct)
    );
    
create table productOrder(
	  idPOproduct int,
	  idPOorder int,
      PoQuantity int default 1,
      PoStatus enum('Disponível','Sem estoque') default 'Disponível',
      primary key (idPOproduct, idPOorder),
      constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
      constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
    );
    
create table storageLocation(
	  idLproduct int,
	  idLstorage int,
      Location varchar(255) not null,
      primary key (idLproduct, idLstorage),
      constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
      constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
    );
    
create table productSupplier(
	  idPsSupplier int,
	  idPsProduct int,
      Quantity int not null,
      primary key (idPsSupplier, idPsProduct),
      constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
      constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
    );
    
    show tables;