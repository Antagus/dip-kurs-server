--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6
-- Dumped by pg_dump version 16.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: create_account(integer, character varying, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_account(p_owner_id integer, p_account_name character varying, p_total_balance numeric, p_currency character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "Account" (owner_id, account_name, total_balance, currency)
    VALUES (p_owner_id, p_account_name, p_total_balance, p_currency);
END;
$$;


ALTER FUNCTION public.create_account(p_owner_id integer, p_account_name character varying, p_total_balance numeric, p_currency character varying) OWNER TO postgres;

--
-- Name: create_category(text, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_category(p_image text, p_category_name character varying, p_user_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "Category" (image, category_name, user_id)
    VALUES (p_image, p_category_name, p_user_id);
END;
$$;


ALTER FUNCTION public.create_category(p_image text, p_category_name character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: create_note(integer, character varying, text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_note(p_user_id integer, p_title character varying, p_description text DEFAULT NULL::text, p_reminder_date timestamp without time zone DEFAULT NULL::timestamp without time zone) RETURNS TABLE(id integer, user_id integer, title character varying, description text, creation_date timestamp without time zone, reminder_date timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    INSERT INTO "Note" (user_id, title, description, reminder_date)
    VALUES (p_user_id, p_title, p_description, p_reminder_date)
    RETURNING "Note".id, "Note".user_id, "Note".title, "Note".description, "Note".creation_date, "Note".reminder_date;
END;
$$;


ALTER FUNCTION public.create_note(p_user_id integer, p_title character varying, p_description text, p_reminder_date timestamp without time zone) OWNER TO postgres;

--
-- Name: create_transaction(integer, integer, integer, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_transaction(p_account_id integer, p_user_id integer, p_category_id integer, p_is_income boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "Transaction" (account_id, user_id, category_id, is_income)
    VALUES (p_account_id, p_user_id, p_category_id, p_is_income);
END;
$$;


ALTER FUNCTION public.create_transaction(p_account_id integer, p_user_id integer, p_category_id integer, p_is_income boolean) OWNER TO postgres;

--
-- Name: create_transaction(integer, integer, integer, boolean, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_transaction(p_account_id integer, p_user_id integer, p_category_id integer, p_is_income boolean, p_amount numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "Transaction" (account_id, user_id, category_id, is_income, transaction_date, amount)
    VALUES (p_account_id, p_user_id, p_category_id, p_is_income, CURRENT_TIMESTAMP, p_amount);
END;
$$;


ALTER FUNCTION public.create_transaction(p_account_id integer, p_user_id integer, p_category_id integer, p_is_income boolean, p_amount numeric) OWNER TO postgres;

--
-- Name: create_user(character varying, character varying, character varying, character varying, character varying, date, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_user(p_first_name character varying, p_last_name character varying, p_middle_name character varying, p_email character varying, p_password character varying, p_date_of_birth date, p_account_type smallint) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "User" (first_name, last_name, middle_name, email, password, date_of_birth, account_type)
    VALUES (p_first_name, p_last_name, p_middle_name, p_email, p_password, p_date_of_birth, p_account_type);
END;
$$;


ALTER FUNCTION public.create_user(p_first_name character varying, p_last_name character varying, p_middle_name character varying, p_email character varying, p_password character varying, p_date_of_birth date, p_account_type smallint) OWNER TO postgres;

--
-- Name: delete_account(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_account(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "Account" WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.delete_account(p_id integer) OWNER TO postgres;

--
-- Name: delete_category(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_category(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "Category" WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.delete_category(p_id integer) OWNER TO postgres;

--
-- Name: delete_note(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_note(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "Note"
    WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.delete_note(p_id integer) OWNER TO postgres;

--
-- Name: delete_transaction(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_transaction(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "Transaction" WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.delete_transaction(p_id integer) OWNER TO postgres;

--
-- Name: delete_user(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_user(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "User" WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.delete_user(p_id integer) OWNER TO postgres;

--
-- Name: generate_income_expense_report(integer, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_income_expense_report(p_user_id integer, p_start_date date, p_end_date date) RETURNS TABLE(total_income numeric, total_expense numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        SUM(CASE WHEN is_income THEN 1 ELSE 0 END * account_id) AS total_income,
        SUM(CASE WHEN NOT is_income THEN 1 ELSE 0 END * account_id) AS total_expense
    FROM "Transaction"
    WHERE user_id = p_user_id
      AND transaction_date BETWEEN p_start_date AND p_end_date;
END;
$$;


ALTER FUNCTION public.generate_income_expense_report(p_user_id integer, p_start_date date, p_end_date date) OWNER TO postgres;

--
-- Name: get_account_balance(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_account_balance(p_account_id integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    balance NUMERIC;
BEGIN
    SELECT total_balance INTO balance
    FROM "Account"
    WHERE id = p_account_id;
    RETURN balance;
END;
$$;


ALTER FUNCTION public.get_account_balance(p_account_id integer) OWNER TO postgres;

--
-- Name: get_account_by_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_account_by_id(p_account_id integer) RETURNS TABLE(id integer, account_name character varying, total_balance numeric, currency character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT "Account".id, "Account".account_name, "Account".total_balance, "Account".currency
    FROM "Account"
    WHERE "Account".id = p_account_id;
END;
$$;


ALTER FUNCTION public.get_account_by_id(p_account_id integer) OWNER TO postgres;

--
-- Name: get_account_transactions(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_account_transactions(p_account_id integer) RETURNS TABLE(id integer, account_id integer, user_id integer, category_id integer, is_income boolean, transaction_date timestamp without time zone, amount numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        "Transaction".id,
        "Transaction".account_id,
        "Transaction".user_id,
        "Transaction".category_id,
        "Transaction".is_income,
        "Transaction".transaction_date,
        "Transaction".amount
    FROM "Transaction"
    WHERE "Transaction".account_id = p_account_id
    ORDER BY transaction_date DESC;
END;
$$;


ALTER FUNCTION public.get_account_transactions(p_account_id integer) OWNER TO postgres;

--
-- Name: get_category_by_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_category_by_id(p_id integer) RETURNS TABLE(id integer, image text, category_name character varying, user_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        "Category".id, 
        "Category".image, 
        "Category".category_name, 
        "Category".user_id
    FROM "Category"
    WHERE "Category".id = p_id;
END;
$$;


ALTER FUNCTION public.get_category_by_id(p_id integer) OWNER TO postgres;

--
-- Name: get_note_by_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_note_by_id(p_id integer) RETURNS TABLE(id integer, user_id integer, title character varying, description text, creation_date timestamp without time zone, reminder_date timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        "Note".id, 
        "Note".user_id, 
        "Note".title, 
        "Note".description, 
        "Note".creation_date, 
        "Note".reminder_date
    FROM "Note"
    WHERE "Note".id = p_id;
END;
$$;


ALTER FUNCTION public.get_note_by_id(p_id integer) OWNER TO postgres;

--
-- Name: get_notes_by_date_range(integer, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_notes_by_date_range(p_user_id integer, p_start_date timestamp without time zone, p_end_date timestamp without time zone) RETURNS TABLE(id integer, user_id integer, title character varying, description text, creation_date timestamp without time zone, reminder_date timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT id, user_id, title, description, creation_date, reminder_date
    FROM "Note"
    WHERE user_id = p_user_id 
      AND creation_date BETWEEN p_start_date AND p_end_date
    ORDER BY creation_date DESC;
END;
$$;


ALTER FUNCTION public.get_notes_by_date_range(p_user_id integer, p_start_date timestamp without time zone, p_end_date timestamp without time zone) OWNER TO postgres;

--
-- Name: get_notes_with_reminders(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_notes_with_reminders(p_user_id integer) RETURNS TABLE(id integer, user_id integer, title character varying, description text, creation_date timestamp without time zone, reminder_date timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT id, user_id, title, description, creation_date, reminder_date
    FROM "Note"
    WHERE user_id = p_user_id AND reminder_date IS NOT NULL
    ORDER BY reminder_date ASC;
END;
$$;


ALTER FUNCTION public.get_notes_with_reminders(p_user_id integer) OWNER TO postgres;

--
-- Name: get_transaction_by_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_transaction_by_id(p_transaction_id integer) RETURNS TABLE(id integer, account_id integer, user_id integer, category_id integer, is_income boolean, transaction_date timestamp without time zone, amount numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        "Transaction".id,
        "Transaction".account_id,
        "Transaction".user_id,
        "Transaction".category_id,
        "Transaction".is_income,
        "Transaction".transaction_date,
        "Transaction".amount
    FROM "Transaction"
    WHERE "Transaction".id = p_transaction_id
    ORDER BY transaction_date DESC;
END;
$$;


ALTER FUNCTION public.get_transaction_by_id(p_transaction_id integer) OWNER TO postgres;

--
-- Name: get_transactions_by_category(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_transactions_by_category(p_category_id integer) RETURNS TABLE(id integer, account_id integer, amount numeric, user_id integer, is_income boolean, transaction_date timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT "Transaction".id, "Transaction".account_id, "Transaction".amount, "Transaction".user_id, "Transaction".is_income, "Transaction".transaction_date
    FROM "Transaction"
    WHERE "Transaction".category_id = p_category_id;
END;
$$;


ALTER FUNCTION public.get_transactions_by_category(p_category_id integer) OWNER TO postgres;

--
-- Name: get_user_accounts(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_user_accounts(p_user_id integer) RETURNS TABLE(id integer, account_name character varying, total_balance numeric, currency character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT "Account".id, "Account".account_name, "Account".total_balance, "Account".currency
    FROM "Account"
    WHERE owner_id = p_user_id;
END;
$$;


ALTER FUNCTION public.get_user_accounts(p_user_id integer) OWNER TO postgres;

--
-- Name: get_user_categories(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_user_categories(p_user_id integer) RETURNS TABLE(id integer, category_name character varying, image text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT "Category".id, "Category".category_name, "Category".image
    FROM "Category"
    WHERE "Category".user_id = p_user_id;
END;
$$;


ALTER FUNCTION public.get_user_categories(p_user_id integer) OWNER TO postgres;

--
-- Name: get_user_info(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_user_info(p_id integer) RETURNS TABLE(id integer, first_name character varying, last_name character varying, email character varying, date_of_birth date, account_type smallint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT "User".id, "User".first_name, "User".last_name, "User".email, "User".date_of_birth, "User".account_type
    FROM "User"
    WHERE "User".id = p_id;
END;
$$;


ALTER FUNCTION public.get_user_info(p_id integer) OWNER TO postgres;

--
-- Name: get_user_notes(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_user_notes(p_user_id integer) RETURNS TABLE(id integer, user_id integer, title character varying, description text, creation_date timestamp without time zone, reminder_date timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT "Note".id, "Note".user_id, "Note".title, "Note".description, "Note".creation_date, "Note".reminder_date
    FROM "Note"
    WHERE "Note".user_id = p_user_id
    ORDER BY "Note".creation_date DESC;
END;
$$;


ALTER FUNCTION public.get_user_notes(p_user_id integer) OWNER TO postgres;

--
-- Name: update_account(integer, character varying, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_account(p_id integer, p_account_name character varying, p_total_balance numeric, p_currency character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "Account"
    SET 
        account_name = p_account_name,
        total_balance = p_total_balance,
        currency = p_currency
    WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.update_account(p_id integer, p_account_name character varying, p_total_balance numeric, p_currency character varying) OWNER TO postgres;

--
-- Name: update_account_balance(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_account_balance() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Увеличение баланса при доходной операции
    IF NEW.is_income THEN
        UPDATE "Account"
        SET total_balance = total_balance + (SELECT amount FROM "Transaction" WHERE id = NEW.id)
        WHERE id = NEW.account_id;
    -- Уменьшение баланса при расходной операции
    ELSE
        UPDATE "Account"
        SET total_balance = total_balance - (SELECT amount FROM "Transaction" WHERE id = NEW.id)
        WHERE id = NEW.account_id;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_account_balance() OWNER TO postgres;

--
-- Name: update_category(integer, character varying, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_category(p_id integer, p_category_name character varying, p_image text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "Category"
    SET 
        category_name = p_category_name,
        image = p_image
    WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.update_category(p_id integer, p_category_name character varying, p_image text) OWNER TO postgres;

--
-- Name: update_note(integer, character varying, text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_note(p_id integer, p_title character varying, p_description text DEFAULT NULL::text, p_reminder_date timestamp without time zone DEFAULT NULL::timestamp without time zone) RETURNS TABLE(id integer, user_id integer, title character varying, description text, creation_date timestamp without time zone, reminder_date timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    UPDATE "Note"
    SET 
        title = p_title,
        description = p_description,
        reminder_date = p_reminder_date
    WHERE "Note".id = p_id
    RETURNING 
        "Note".id, 
        "Note".user_id, 
        "Note".title, 
        "Note".description, 
        "Note".creation_date, 
        "Note".reminder_date;
END;
$$;


ALTER FUNCTION public.update_note(p_id integer, p_title character varying, p_description text, p_reminder_date timestamp without time zone) OWNER TO postgres;

--
-- Name: update_transaction(integer, integer, integer, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_transaction(p_id integer, p_account_id integer, p_category_id integer, p_is_income boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "Transaction"
    SET 
        account_id = p_account_id,
        category_id = p_category_id,
        is_income = p_is_income
    WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.update_transaction(p_id integer, p_account_id integer, p_category_id integer, p_is_income boolean) OWNER TO postgres;

--
-- Name: update_user(integer, character varying, character varying, character varying, character varying, character varying, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_user(p_id integer, p_first_name character varying, p_last_name character varying, p_middle_name character varying, p_email character varying, p_password character varying, p_account_type smallint) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "User"
    SET 
        first_name = p_first_name,
        last_name = p_last_name,
        middle_name = p_middle_name,
        email = p_email,
        password = p_password,
        account_type = p_account_type
    WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.update_user(p_id integer, p_first_name character varying, p_last_name character varying, p_middle_name character varying, p_email character varying, p_password character varying, p_account_type smallint) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Account" (
    id integer NOT NULL,
    owner_id integer NOT NULL,
    account_name character varying(100) NOT NULL,
    creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_balance numeric(15,2) DEFAULT 0 NOT NULL,
    currency character varying(10) DEFAULT 'RUB'::character varying NOT NULL
);


ALTER TABLE public."Account" OWNER TO postgres;

--
-- Name: Account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Account_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Account_id_seq" OWNER TO postgres;

--
-- Name: Account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Account_id_seq" OWNED BY public."Account".id;


--
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    image text,
    category_name character varying(100) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Category_id_seq" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: Note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Note" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(100) NOT NULL,
    description text,
    creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    reminder_date timestamp without time zone
);


ALTER TABLE public."Note" OWNER TO postgres;

--
-- Name: Note_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Note_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Note_id_seq" OWNER TO postgres;

--
-- Name: Note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Note_id_seq" OWNED BY public."Note".id;


--
-- Name: Transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaction" (
    id integer NOT NULL,
    account_id integer NOT NULL,
    user_id integer NOT NULL,
    category_id integer,
    is_income boolean NOT NULL,
    transaction_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    amount numeric(15,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public."Transaction" OWNER TO postgres;

--
-- Name: Transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transaction_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transaction_id_seq" OWNER TO postgres;

--
-- Name: Transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transaction_id_seq" OWNED BY public."Transaction".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    middle_name character varying(100),
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    date_of_birth date NOT NULL,
    registration_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    account_type smallint NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: Account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account" ALTER COLUMN id SET DEFAULT nextval('public."Account_id_seq"'::regclass);


--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: Note id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note" ALTER COLUMN id SET DEFAULT nextval('public."Note_id_seq"'::regclass);


--
-- Name: Transaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction" ALTER COLUMN id SET DEFAULT nextval('public."Transaction_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Account" (id, owner_id, account_name, creation_date, total_balance, currency) FROM stdin;
2	2	Сбережения	2024-11-23 20:35:56.703372	100000.00	RUB
4	4	Зарплатный счет	2024-11-23 20:35:56.703372	75000.00	RUB
5	5	Депозит	2024-11-23 20:35:56.703372	150000.00	RUB
6	6	Основной счет	2024-11-23 20:35:56.703372	60000.25	RUB
7	7	Накопительный	2024-11-23 20:35:56.703372	200000.00	RUB
8	8	Покупки	2024-11-23 20:35:56.703372	30000.50	RUB
9	9	Сбережения	2024-11-23 20:35:56.703372	50000.75	RUB
10	10	Основной счет	2024-11-23 20:35:56.703372	70000.00	RUB
1	1	Основной счет	2024-11-23 20:35:56.703372	50500.50	RUB
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" (id, image, category_name, user_id) FROM stdin;
1	https://example.com/images/groceries.png	Продукты	1
2	https://example.com/images/rent.png	Аренда	2
4	https://example.com/images/transport.png	Транспорт	4
5	https://example.com/images/health.png	Здоровье	5
6	https://example.com/images/education.png	Образование	6
7	https://example.com/images/savings.png	Сбережения	7
8	https://example.com/images/shopping.png	Шопинг	8
9	https://example.com/images/utilities.png	Коммунальные услуги	9
10	https://example.com/images/other.png	Прочее	10
12	http://example.com/image.jpg	Groceries	1
13	http://example.com/image.jpg	Groceries	1
11	http://example.com/updated-image.jpg	Updated Groceries	1
\.


--
-- Data for Name: Note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Note" (id, user_id, title, description, creation_date, reminder_date) FROM stdin;
1	1	Напоминание об аренде	Оплатить аренду до 5 числа	2024-11-23 20:35:56.703372	2024-11-05 00:00:00
4	4	Записаться к врачу	Посетить врача в поликлинике	2024-11-23 20:35:56.703372	2024-11-15 00:00:00
5	5	Купить подарок	Подготовить подарок к дню рождения	2024-11-23 20:35:56.703372	2024-11-20 00:00:00
6	6	Заплатить за интернет	Оплата интернета за месяц	2024-11-23 20:35:56.703372	2024-11-25 00:00:00
7	7	Сделать перевод	Перевод на накопительный счет	2024-11-23 20:35:56.703372	2024-11-30 00:00:00
8	8	Установить приложение	Установить банковское приложение	2024-11-23 20:35:56.703372	2024-12-01 00:00:00
9	9	Спланировать отпуск	Выбрать место отдыха и даты	2024-11-23 20:35:56.703372	2024-12-05 00:00:00
10	10	Заполнить налоговую декларацию	Подготовить документы для подачи	2024-11-23 20:35:56.703372	2024-12-10 00:00:00
2	2	Купить продукты	Составить список пfdокупок 345r	2024-11-23 20:35:56.703372	\N
\.


--
-- Data for Name: Transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaction" (id, account_id, user_id, category_id, is_income, transaction_date, amount) FROM stdin;
1	1	1	1	f	2024-11-01 00:00:00	0.00
2	2	2	2	f	2024-11-02 00:00:00	0.00
4	4	4	4	f	2024-11-04 00:00:00	0.00
5	5	5	5	t	2024-11-05 00:00:00	0.00
6	6	6	6	t	2024-11-06 00:00:00	0.00
7	7	7	7	f	2024-11-07 00:00:00	0.00
8	8	8	8	f	2024-11-08 00:00:00	0.00
9	9	9	9	t	2024-11-09 00:00:00	0.00
10	10	10	10	f	2024-11-10 00:00:00	0.00
11	1	1	2	t	2024-11-11 00:00:00	0.00
14	4	4	5	f	2024-11-14 00:00:00	0.00
15	5	5	6	t	2024-11-15 00:00:00	0.00
16	6	6	7	f	2024-11-16 00:00:00	0.00
17	7	7	8	f	2024-11-17 00:00:00	0.00
18	8	8	9	t	2024-11-18 00:00:00	0.00
19	9	9	10	f	2024-11-19 00:00:00	0.00
20	10	10	1	t	2024-11-20 00:00:00	0.00
12	2	2	\N	t	2024-11-12 00:00:00	0.00
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, first_name, last_name, middle_name, email, password, date_of_birth, registration_date, account_type) FROM stdin;
1	Иван	Иванов	Иванович	ivan.ivanov@example.com	password1	1985-01-15	2024-11-23 20:35:56.703372	1
2	Петр	Петров	Петрович	petr.petrov@example.com	password2	1990-02-20	2024-11-23 20:35:56.703372	2
4	Ольга	Сидорова	Викторовна	olga.sidorova@example.com	password4	1987-05-12	2024-11-23 20:35:56.703372	1
5	Алексей	Кузнецов	Сергеевич	alexey.kuznetsov@example.com	password5	1992-07-18	2024-11-23 20:35:56.703372	2
6	Елена	Попова	Дмитриевна	elena.popova@example.com	password6	1980-11-25	2024-11-23 20:35:56.703372	1
7	Максим	Васильев	Игоревич	maxim.vasiliev@example.com	password7	1993-04-05	2024-11-23 20:35:56.703372	2
8	Мария	Новикова	Александровна	maria.novikova@example.com	password8	1988-06-30	2024-11-23 20:35:56.703372	1
9	Дмитрий	Морозов	Олегович	dmitry.morozov@example.com	password9	1989-09-10	2024-11-23 20:35:56.703372	2
10	Светлана	Федорова	Геннадьевна	svetlana.fedorova@example.com	password10	1991-10-22	2024-11-23 20:35:56.703372	1
14	John	Doe	Michael	john.doe@example.com	securepassword	1990-01-01	2024-11-25 22:38:10.32063	1
\.


--
-- Name: Account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Account_id_seq"', 11, true);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 13, true);


--
-- Name: Note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Note_id_seq"', 11, true);


--
-- Name: Transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaction_id_seq"', 21, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 14, true);


--
-- Name: Account Account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: Note Note_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_pkey" PRIMARY KEY (id);


--
-- Name: Transaction Transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_pkey" PRIMARY KEY (id);


--
-- Name: User User_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: Transaction transaction_account_balance_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER transaction_account_balance_update AFTER INSERT ON public."Transaction" FOR EACH ROW EXECUTE FUNCTION public.update_account_balance();


--
-- Name: Account Account_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES public."User"(id) ON DELETE CASCADE;


--
-- Name: Category Category_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON DELETE CASCADE;


--
-- Name: Note Note_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON DELETE CASCADE;


--
-- Name: Transaction Transaction_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_account_id_fkey" FOREIGN KEY (account_id) REFERENCES public."Account"(id) ON DELETE CASCADE;


--
-- Name: Transaction Transaction_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."Category"(id) ON DELETE SET NULL;


--
-- Name: Transaction Transaction_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

