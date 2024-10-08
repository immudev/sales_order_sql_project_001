PGDMP                      |            ecomax    16.3    16.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    65576    ecomax    DATABASE     �   CREATE DATABASE ecomax WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE ecomax;
                postgres    false            �            1259    65584 	   customers    TABLE     }   CREATE TABLE public.customers (
    id integer NOT NULL,
    name character varying(100),
    email character varying(30)
);
    DROP TABLE public.customers;
       public         heap    postgres    false            �            1259    65583    customers_id_seq    SEQUENCE     �   ALTER TABLE public.customers ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            �            1259    65590 	   employees    TABLE     \   CREATE TABLE public.employees (
    id integer NOT NULL,
    name character varying(100)
);
    DROP TABLE public.employees;
       public         heap    postgres    false            �            1259    65589    employees_id_seq    SEQUENCE     �   ALTER TABLE public.employees ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220            �            1259    65578    products    TABLE     �   CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(100),
    price double precision,
    release_date date
);
    DROP TABLE public.products;
       public         heap    postgres    false            �            1259    65577    products_id_seq    SEQUENCE     �   ALTER TABLE public.products ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    216            �            1259    65596    sales_order    TABLE     �   CREATE TABLE public.sales_order (
    order_id integer NOT NULL,
    order_date date,
    quantity integer,
    prod_id integer,
    status character varying(20),
    customer_id integer,
    emp_id integer
);
    DROP TABLE public.sales_order;
       public         heap    postgres    false            �            1259    65595    sales_order_order_id_seq    SEQUENCE     �   ALTER TABLE public.sales_order ALTER COLUMN order_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sales_order_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    222            �          0    65584 	   customers 
   TABLE DATA           4   COPY public.customers (id, name, email) FROM stdin;
    public          postgres    false    218   �       �          0    65590 	   employees 
   TABLE DATA           -   COPY public.employees (id, name) FROM stdin;
    public          postgres    false    220   S       �          0    65578    products 
   TABLE DATA           A   COPY public.products (id, name, price, release_date) FROM stdin;
    public          postgres    false    216   �                  0    65596    sales_order 
   TABLE DATA           k   COPY public.sales_order (order_id, order_date, quantity, prod_id, status, customer_id, emp_id) FROM stdin;
    public          postgres    false    222                     0    0    customers_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.customers_id_seq', 4, true);
          public          postgres    false    217                       0    0    employees_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.employees_id_seq', 3, true);
          public          postgres    false    219            	           0    0    products_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.products_id_seq', 5, true);
          public          postgres    false    215            
           0    0    sales_order_order_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.sales_order_order_id_seq', 10, true);
          public          postgres    false    221            b           2606    65588    customers customers_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.customers DROP CONSTRAINT customers_pkey;
       public            postgres    false    218            d           2606    65594    employees employees_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public            postgres    false    220            `           2606    65582    products products_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    216            f           2606    65600    sales_order sales_order_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.sales_order
    ADD CONSTRAINT sales_order_pkey PRIMARY KEY (order_id);
 F   ALTER TABLE ONLY public.sales_order DROP CONSTRAINT sales_order_pkey;
       public            postgres    false    222            g           2606    65606 (   sales_order sales_order_customer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sales_order
    ADD CONSTRAINT sales_order_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);
 R   ALTER TABLE ONLY public.sales_order DROP CONSTRAINT sales_order_customer_id_fkey;
       public          postgres    false    222    4706    218            h           2606    65611 #   sales_order sales_order_emp_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sales_order
    ADD CONSTRAINT sales_order_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES public.employees(id);
 M   ALTER TABLE ONLY public.sales_order DROP CONSTRAINT sales_order_emp_id_fkey;
       public          postgres    false    220    222    4708            i           2606    65601 $   sales_order sales_order_prod_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sales_order
    ADD CONSTRAINT sales_order_prod_id_fkey FOREIGN KEY (prod_id) REFERENCES public.products(id);
 N   ALTER TABLE ONLY public.sales_order DROP CONSTRAINT sales_order_prod_id_fkey;
       public          postgres    false    216    222    4704            �   `   x�3��MM�H�S�H,�I���� �)���z���\F�A�ŉ
�@5�E�@!e�铟���_TS��&�Q�E��
.�٩�U)@!���� $(�      �   6   x�3����KT�.�M,��2�tL*J,R��H��2��,J�KUp�/.I����� B�      �   v   x�-�A
�@@�ur��@J�I@��0�n�LUPZ�ޟu��_`)s|�$3(k&nH�uxF�R�TNU&Q�Э�{J���Ԃ�����[G�3�c���-[�q��8Sf�o���A�          �   x�]б!���S�Z����M��b��h�s��c98S��q֎���q�2>�!�P�����ѱ�(4�����8Xc��a�}Z��]��TV�)�p�0���E��j�^Ҿ�h�:Wf���ح$�yv&�Ħ!uq�놈��A�     