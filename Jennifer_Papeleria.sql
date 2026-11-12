-- PROYECTO: SISTEMA DE PAPELERÍA
-- MÓDULO: FACTURACIÓN
-- Jeniffer Yanez
-- Script de creación de tablas, secuencias y triggers

--CREACIÓN DE TABLAS
CREATE TABLE USUARIOS (
    id_usuario VARCHAR2(10) PRIMARY KEY,
    username VARCHAR2(50) UNIQUE,
    password VARCHAR2(50),
    rol VARCHAR2(20)
);

CREATE TABLE CIUDAD (
    codigo VARCHAR2(10) PRIMARY KEY,
    nombre VARCHAR2(50)
);

CREATE TABLE CLIENTE (
    ruc VARCHAR2(13) PRIMARY KEY,
    nombre VARCHAR2(100),
    direccion VARCHAR2(150)
);

CREATE TABLE ARTICULO (
    codigo VARCHAR2(10) PRIMARY KEY,
    nombre VARCHAR2(100),
    precio NUMBER(10,2),
    stock NUMBER(10) 
);

CREATE TABLE FACTURA_CAB (
    numero VARCHAR2(20) PRIMARY KEY,
    fecha DATE,
    ciudad_codigo VARCHAR2(10),
    cliente_ruc VARCHAR2(13),
    total NUMBER(10,2),
    FOREIGN KEY (ciudad_codigo) REFERENCES CIUDAD(codigo),
    FOREIGN KEY (cliente_ruc) REFERENCES CLIENTE(ruc)
);

CREATE TABLE FACTURA_DET (
    factura_numero VARCHAR2(20),
    articulo_codigo VARCHAR2(10),
    cantidad NUMBER(10),
    precio NUMBER(10,2),
    PRIMARY KEY (factura_numero, articulo_codigo),
    FOREIGN KEY (factura_numero) REFERENCES FACTURA_CAB(numero),
    FOREIGN KEY (articulo_codigo) REFERENCES ARTICULO(codigo)
);

--CREACIÓN DE SECUENCIAS
CREATE SEQUENCE seq_usuario START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ciudad START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cliente START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_articulo START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_factura START WITH 1 INCREMENT BY 1;

--CREACIÓN DE TRIGGERS
CREATE OR REPLACE TRIGGER trg_usuario 
BEFORE INSERT ON USUARIOS 
FOR EACH ROW 
BEGIN 
    IF :NEW.id_usuario IS NULL THEN 
        :NEW.id_usuario := 'U-' || seq_usuario.NEXTVAL; 
    END IF; 
END;
/

CREATE OR REPLACE TRIGGER trg_ciudad 
BEFORE INSERT ON CIUDAD 
FOR EACH ROW 
BEGIN 
    IF :NEW.codigo IS NULL THEN 
        :NEW.codigo := 'C-' || seq_ciudad.NEXTVAL; 
    END IF; 
END;
/

CREATE OR REPLACE TRIGGER trg_cliente 
BEFORE INSERT ON CLIENTE 
FOR EACH ROW 
BEGIN 
    IF :NEW.ruc IS NULL THEN 
        :NEW.ruc := 'CL-' || seq_cliente.NEXTVAL; 
    END IF; 
END;
/

CREATE OR REPLACE TRIGGER trg_articulo 
BEFORE INSERT ON ARTICULO 
FOR EACH ROW 
BEGIN 
    IF :NEW.codigo IS NULL THEN 
        :NEW.codigo := 'A-' || seq_articulo.NEXTVAL; 
    END IF; 
END;
/

CREATE OR REPLACE TRIGGER trg_factura 
BEFORE INSERT ON FACTURA_CAB 
FOR EACH ROW 
BEGIN 
    IF :NEW.numero IS NULL THEN 
        :NEW.numero := 'F-' || seq_factura.NEXTVAL; 
    END IF; 
END;
/