-- desafio dio e-commerce
-- creating database 
-- drop database ecommerce;
create database ecommerce;
use ecommerce;


-- creating table_cliente
CREATE TABLE clients (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(10),
    minit CHAR(3),
    last_name VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    CNPJ char (14),
    address VARCHAR(150),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
);
alter table clients auto_increment=1;

-- idClient, Fname, Minit, Lname, CPF, Address
insert into clients (first_name, Minit, last_name, CPF, address)
values('Maria','M','Silva',12346789,'rua silva de prata 29, Carangola - Cidade das flores'),
      ('Matheus','O','Pimentel',987654321,'rua alemeda 289, Centro - Cidade das flores'),
      ('Ricardo','F','Silva',45678913,'avenida alÊmeda vinha 1009, Centro - Cidade das flores'),
      ('Julia','S','França',789123456,'rua lareíjras 861, Centro - Cidade das flores'),
      ('Roberta','G','Assis',98745631,'avenidade koller 19, Centro - Cidade das flores'),
      ('Isabela','M','Cruz',654789123,'rua alemeda das flores 28, Centro - Cidade das flores');


-- creating table_product
CREATE TABLE product (
    id_product INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(30) NOT NULL,
    classification_kids BOOL DEFAULT FALSE,
    category ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
    feedback FLOAT DEFAULT 0,
    size VARCHAR(10)
);

-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
insert into product (product_name, classification_kids, category, feedback, size) values
('Fone de ouvido', False, 'Eletrônico', '4', null),
('Barbie Elsa', True, 'Brinquedos', '3', null),
('Body Carters', True, 'Vestimenta', '5', null),
('Microfone Vedo - Youtuber', False, 'Eletrônico', '4', null),
('Sofá retrátil', False, 'Móveis', '3', '3x57x80'),
('Farinha de arroz', False, 'Alimentos', '2', null),
('Fire Stick Amazon', False, 'Eletrônico', '3', null);

-- creating table payments -- pendente relacionamentos
CREATE TABLE payments (
    id_payment_client INT,
    id_payment INT not null auto_increment primary key,
    type_payment ENUM('Boleto', 'Cartão', 'PIX', 'Dois cartões'),
    limit_available FLOAT,
    payment_status ENUM('Cancelado', 'Aprovado', 'Em processamento', 'Não realizado') default 'Não realizado',
    CONSTRAINT fk_id_payment_client FOREIGN KEY (id_payment_client) REFERENCES clients (id_client)
  );
  
insert into payments (id_payment, payment_status) values
(1,'Cancelado'),
(3,'Não realizado'),
(5,'Em processamento'),
(7, default);

-- creating table entrega
create table entrega (
id_entrega int primary key,
status_entrega enum('Enviado', 'Aguardando postagem', 'Entregue', 'Tentativa de entrega'),
data_entrega varchar (10));

insert into entrega (id_entrega, status_entrega, data_entrega) values
(2,'Enviado', 10-02-2024),
(4, 'Entregue', 09-02-2024),
(6,'Tentativa de entrega',20-02-2024),
(8, 'Aguardando postagem',28-02-2024);

-- creating table orders 
CREATE TABLE orders (
    id_orders INT AUTO_INCREMENT PRIMARY KEY,
    id_orders_client INT,
    orders_status ENUM('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orders_description VARCHAR(255),
    orders_freight FLOAT DEFAULT 10,
    payment_Cash BOOLean DEFAULT FALSE,
CONSTRAINT fk_orders_client FOREIGN KEY (id_orders_client) REFERENCES clients (id_client)
);
select * from orders;
alter table orders add column id_payment int,
add constraint fk_orders_payment foreign key (id_payment) references payments (id_payment);

alter table orders add column id_entrega int,
add constraint fk_orders_entrega foreign key (id_entrega) references entrega (id_entrega);

-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
insert into orders (id_orders, orders_status, orders_description, orders_freight, payment_cash, id_payment, id_entrega) values
(1, default, 'compra via aplicativo', null, 1,1,2),
(2, default, 'compra via aplicativo', 50, 0,3,4),
(3, 'Confirmado', null, null, 1,5,6),
(4, default, 'compra via web site', 150, 0,7,8);


-- creating table storage
create table product_storage(
id_product_storage int auto_increment primary key,
storage_location varchar (255),
quantity int default 0
);

insert into product_storage (storage_location, quantity) values
('Rio de Janeiro', 1000),
('Rio de Janeiro', 500),
('Sao Paulo', 10),
('Sao Paulo', 100),
('Sao Paulo', 10),
('Brasilia', 60);

-- creating  table supplier
create table supplier(
id_supplier int auto_increment primary key,
social_name varchar (255) not null,
CNPJ char (15) not null,
contact char (11) not null,
constraint unique_supplier unique (CNPJ) 
);

insert into supplier (social_name, CNPJ, contact) values
('Alemida e Filhos', 123456789123456, '21985474'),
('Eletronicos Silva', 85451964914457, '21985484'),
('Eletronicos Valma', 934567893934695, '21975475');


-- creating table seller
create table seller (
id_seller int auto_increment primary key,
social_name varchar (255) not null,
abstract_name varchar (255),
CNPJ char (15), 
CPF char (09),
location varchar (255),
contact char (11) not null,
constraint unique_cnpj_supplier unique (CNPJ),
constraint unique_cpf_supplier unique (CPF)
);

insert into seller ( social_name, abstract_name, CNPJ, CPF, location, contact) values
('Tech Eletronics', null, 12345789456321, null, 'Rio de Janeiro', 219946287),
('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 219567895),
('Kids World', null, 456789123654485, null, 'Sao Paulo', 11989657484);



-- creating table product_seller
create table product_seller (
id_product_seller int,
id_product int,
product_quantity int default 1,
primary key (id_product_seller, id_product),
constraint fk_product_seller foreign key (id_product_seller) references seller(id_seller),
constraint fk_product_product foreign key (id_product) references product(id_product)
);

insert into product_seller (id_product_seller, id_product, product_quantity) values
(1,6,80),
(2,7,10);

-- creating table product_order
create table product_order (
id_product_order_product int,
id_product_order_order int,
product_order_quantity int default 1,
product_order_status enum('Disponível', 'Sem estoque') default 'Disponível',
primary key (id_product_order_product, id_product_order_order),
constraint fk_productorder_seller foreign key (id_product_order_product) references product(id_product),
constraint fk_productorder_product foreign key (id_product_order_order) references orders(id_orders)
);

insert into product_order (id_product_order_product, id_product_order_order, product_order_quantity, product_order_status) values
(1,1,2,null),
(2,1,1,null),
(3,2,1,null);

-- creating table storage_location
CREATE TABLE storage_location (
    id_location_product INT,
    id_location_storage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_location_product , id_location_storage),
    CONSTRAINT fk_storagelocation_product FOREIGN KEY (id_location_product) REFERENCES product (id_product),
    CONSTRAINT fk_storagelocation_storage FOREIGN KEY (id_location_storage) REFERENCES product_storage (id_product_storage)
);

insert into storage_location (id_location_product, id_location_storage, location) values
(1,2, 'RJ'),
(2,6, 'GO');

-- creating table product_supplier
create table product_supplier (
id_productsupplier_supplier int,
id_productsupplier_product int,
quantity int not null,
primary key (id_productsupplier_supplier, id_productsupplier_product),
constraint fk_productsupplier_supplier foreign key (id_productsupplier_supplier) references supplier (id_supplier),
constraint fk_productsupplier_product foreign key (id_productsupplier_product) references product (id_product)
);

insert into product_supplier (id_productsupplier_supplier, id_productsupplier_product, quantity) values
(1,1,500),
(1,2,400),
(2,4,633),
(3,3,5),
(2,5,10);

 -- quantos pedidos foram realizados pelos clientes
  select c.id_client, first_name, count(*) as number_of_orders from clients c 
 inner join orders o on c.id_client = o.id_orders 
group by id_client;
 
 -- algum vendedor tambem é fornecedor
select sl.id_seller, sl.social_name as seller_social_name, sp.id_supplier, sp.social_name as supplier_social_name from seller sl, supplier sp
having sl.id_seller = sp.id_supplier;

-- relacao de produtos fornecedores e estoques + nomes dos produtos
select p.product_name, p.category, sl.location, ps.quantity, sp.social_name as supplier_social_name from product p 
inner join product_storage ps
inner join storage_location sl
inner join supplier sp
order by quantity;


