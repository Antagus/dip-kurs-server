--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

-- Started on 2025-06-23 03:56:55

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
-- TOC entry 898 (class 1247 OID 32769)
-- Name: category_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.category_type AS ENUM (
    'Расход',
    'Доход'
);


ALTER TYPE public.category_type OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 16399)
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
-- TOC entry 226 (class 1255 OID 16400)
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
-- TOC entry 240 (class 1255 OID 32775)
-- Name: create_category(text, character varying, integer, public.category_type, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_category(p_image text, p_category_name character varying, p_user_id integer, p_category_type public.category_type, p_color character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO public."Category"
    (image, category_name, user_id, category_type, color)
  VALUES
    (p_image, p_category_name, p_user_id, p_category_type, p_color);
END;
$$;


ALTER FUNCTION public.create_category(p_image text, p_category_name character varying, p_user_id integer, p_category_type public.category_type, p_color character varying) OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 16401)
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
-- TOC entry 228 (class 1255 OID 16402)
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
-- TOC entry 244 (class 1255 OID 16514)
-- Name: create_transaction(integer, integer, integer, boolean, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_transaction(p_account_id integer, p_user_id integer, p_category_id integer, p_is_income boolean, p_amount numeric, p_transaction_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO public."Transaction" (
        account_id, user_id, category_id, is_income, transaction_date, amount, transaction_name
    )
    VALUES (
        p_account_id, p_user_id, p_category_id, p_is_income, CURRENT_TIMESTAMP, p_amount, p_transaction_name
    );
END;
$$;


ALTER FUNCTION public.create_transaction(p_account_id integer, p_user_id integer, p_category_id integer, p_is_income boolean, p_amount numeric, p_transaction_name character varying) OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 16404)
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
-- TOC entry 230 (class 1255 OID 16405)
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
-- TOC entry 231 (class 1255 OID 16406)
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
-- TOC entry 232 (class 1255 OID 16407)
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
-- TOC entry 233 (class 1255 OID 16408)
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
-- TOC entry 234 (class 1255 OID 16409)
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
-- TOC entry 235 (class 1255 OID 16410)
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
-- TOC entry 236 (class 1255 OID 16411)
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
-- TOC entry 237 (class 1255 OID 16412)
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
-- TOC entry 239 (class 1255 OID 16413)
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
-- TOC entry 269 (class 1255 OID 32780)
-- Name: get_category_by_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_category_by_id(p_id integer) RETURNS TABLE(id integer, image text, category_name character varying, user_id integer, color character varying, category_type public.category_type)
    LANGUAGE plpgsql
    AS $$

BEGIN
    RETURN QUERY
    SELECT 
        "Category".id, 
        "Category".image, 
        "Category".category_name, 
        "Category".user_id,
		"Category".color,
		"Category".category_type
    FROM "Category"
    WHERE "Category".id = p_id;
END;
$$;


ALTER FUNCTION public.get_category_by_id(p_id integer) OWNER TO postgres;

--
-- TOC entry 241 (class 1255 OID 16415)
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
-- TOC entry 242 (class 1255 OID 16416)
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
-- TOC entry 243 (class 1255 OID 16417)
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
-- TOC entry 251 (class 1255 OID 16418)
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
-- TOC entry 259 (class 1255 OID 16419)
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
-- TOC entry 260 (class 1255 OID 16420)
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
-- TOC entry 245 (class 1255 OID 32776)
-- Name: get_user_categories(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_user_categories(p_user_id integer) RETURNS TABLE(id integer, category_name character varying, image text, category_type public.category_type, color character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT
    c.id,
    c.category_name,
    c.image,
    c.category_type,
    c.color
  FROM public."Category" AS c
  WHERE c.user_id = p_user_id;
END;
$$;


ALTER FUNCTION public.get_user_categories(p_user_id integer) OWNER TO postgres;

--
-- TOC entry 268 (class 1255 OID 24580)
-- Name: get_user_id_by_credentials(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_user_id_by_credentials(p_email character varying, p_password character varying) RETURNS TABLE(id integer, full_name text, email character varying, date_of_birth date)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
      u.id AS id,

      -- Склеиваем ФИО в одну строку (пробелы между ними).
      -- Если middle_name IS NULL, то вместо него просто пустая строка (двойной пробел не образуется).
      (
        u.first_name
        ||
        CASE 
          WHEN u.middle_name IS NOT NULL AND u.middle_name <> '' 
            THEN ' ' || u.middle_name 
          ELSE '' 
        END
        || ' ' || u.last_name
      ) AS full_name,

      u.email       AS user_email,
      u.date_of_birth
    FROM public."User" AS u
    WHERE u.email    = p_email
      AND u.password = p_password;
END;
$$;


ALTER FUNCTION public.get_user_id_by_credentials(p_email character varying, p_password character varying) OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 16422)
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
-- TOC entry 262 (class 1255 OID 16423)
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
-- TOC entry 263 (class 1255 OID 16424)
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
-- TOC entry 264 (class 1255 OID 16425)
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
-- TOC entry 265 (class 1255 OID 16426)
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
-- TOC entry 246 (class 1255 OID 32777)
-- Name: update_category(integer, character varying, text, public.category_type, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_category(p_id integer, p_category_name character varying, p_image text, p_category_type public.category_type, p_color character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  UPDATE public."Category"
  SET
    category_name = p_category_name,
    image         = p_image,
    category_type = p_category_type,
    color         = p_color
  WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.update_category(p_id integer, p_category_name character varying, p_image text, p_category_type public.category_type, p_color character varying) OWNER TO postgres;

--
-- TOC entry 266 (class 1255 OID 16427)
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
-- TOC entry 267 (class 1255 OID 16428)
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
-- TOC entry 238 (class 1255 OID 16429)
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
-- TOC entry 215 (class 1259 OID 16430)
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
-- TOC entry 216 (class 1259 OID 16436)
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
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 216
-- Name: Account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Account_id_seq" OWNED BY public."Account".id;


--
-- TOC entry 217 (class 1259 OID 16437)
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    image text,
    category_name character varying(100) NOT NULL,
    user_id integer NOT NULL,
    category_type public.category_type DEFAULT 'Расход'::public.category_type NOT NULL,
    color character varying(7) DEFAULT '#000000'::character varying NOT NULL
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16442)
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
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 218
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- TOC entry 219 (class 1259 OID 16443)
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
-- TOC entry 220 (class 1259 OID 16449)
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
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 220
-- Name: Note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Note_id_seq" OWNED BY public."Note".id;


--
-- TOC entry 221 (class 1259 OID 16450)
-- Name: Transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaction" (
    id integer NOT NULL,
    account_id integer NOT NULL,
    user_id integer NOT NULL,
    category_id integer,
    is_income boolean NOT NULL,
    transaction_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    amount numeric(15,2) DEFAULT 0 NOT NULL,
    transaction_name character varying
);


ALTER TABLE public."Transaction" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16455)
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
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 222
-- Name: Transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transaction_id_seq" OWNED BY public."Transaction".id;


--
-- TOC entry 223 (class 1259 OID 16456)
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
-- TOC entry 224 (class 1259 OID 16462)
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
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 224
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- TOC entry 4745 (class 2604 OID 16463)
-- Name: Account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account" ALTER COLUMN id SET DEFAULT nextval('public."Account_id_seq"'::regclass);


--
-- TOC entry 4749 (class 2604 OID 16464)
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- TOC entry 4752 (class 2604 OID 16465)
-- Name: Note id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note" ALTER COLUMN id SET DEFAULT nextval('public."Note_id_seq"'::regclass);


--
-- TOC entry 4754 (class 2604 OID 16466)
-- Name: Transaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction" ALTER COLUMN id SET DEFAULT nextval('public."Transaction_id_seq"'::regclass);


--
-- TOC entry 4757 (class 2604 OID 16467)
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- TOC entry 4921 (class 0 OID 16430)
-- Dependencies: 215
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
12	14	Тестовый счет	2025-05-11 23:42:44.939665	0.00	RUB
34	15	fsdfsdf	2025-06-01 16:26:07.922697	1243213.00	RUB
19	15	Тестовый счет 2	2025-05-26 03:35:32.513999	4533668.00	RUB
39	15	Тестовый счет	2025-06-16 16:07:11.085214	0.00	XBT
15	15	Тестовый счет	2025-05-26 01:43:16.561978	-597502.72	RUB
40	15	Эфрик	2025-06-16 21:33:58.011416	0.07	ETH
28	18	Тестовый счет 1	2025-05-26 10:37:34.791927	6101.00	RUB
\.


--
-- TOC entry 4923 (class 0 OID 16437)
-- Dependencies: 217
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" (id, image, category_name, user_id, category_type, color) FROM stdin;
1	https://example.com/images/groceries.png	Продукты	1	Расход	#000000
2	https://example.com/images/rent.png	Аренда	2	Расход	#000000
4	https://example.com/images/transport.png	Транспорт	4	Расход	#000000
5	https://example.com/images/health.png	Здоровье	5	Расход	#000000
6	https://example.com/images/education.png	Образование	6	Расход	#000000
7	https://example.com/images/savings.png	Сбережения	7	Расход	#000000
8	https://example.com/images/shopping.png	Шопинг	8	Расход	#000000
9	https://example.com/images/utilities.png	Коммунальные услуги	9	Расход	#000000
10	https://example.com/images/other.png	Прочее	10	Расход	#000000
12	http://example.com/image.jpg	Groceries	1	Расход	#000000
13	http://example.com/image.jpg	Groceries	1	Расход	#000000
11	http://example.com/updated-image.jpg	Updated Groceries	1	Расход	#000000
22		Продукты	15	Расход	#903e37
23		Машина	15	Расход	#CCFF90
24		Развлечения	15	Расход	#B388FF
25		Ресторан	15	Расход	#80D8FF
26		Игры	15	Расход	#FFD180
27		Работа	15	Доход	#84c33c
29		Бизнес	15	Доход	#5b91c2
\.


--
-- TOC entry 4925 (class 0 OID 16443)
-- Dependencies: 219
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
12	15	Тестовый счет	32113	2025-06-16 23:10:55.498029	\N
13	15	Гусев Анатолий Михайлович	32113	2025-06-16 23:18:10.562171	\N
14	15	Гусев Анатолий Михайлович	32113	2025-06-16 23:19:53.299507	\N
15	15	Гусев Анатолий Михайлович	32113	2025-06-16 23:20:03.201312	\N
16	15	Гусев Анатолий Михайлович	1233	2025-06-16 23:21:31.951794	\N
17	15	Гусев Анатолий Михайлович	1233	2025-06-16 23:23:19.673109	2025-06-16 20:21:25.405
18	15	Гусев Анатолий Михайлович	32113	2025-06-16 23:23:44.619619	2025-06-16 21:00:00
19	15	Тестовый счет	32113	2025-06-16 23:24:10.815819	2025-06-17 21:00:00
20	15	Тестовый счет	32113	2025-06-16 23:29:48.692554	2025-06-17 21:00:00
21	15	Тестовый счет	32113	2025-06-16 23:38:11.374399	2025-06-17 21:00:00
22	15	Тестовый счет	32113	2025-06-16 23:39:01.836376	2025-06-18 00:00:00
23	15	Тестовый счет	32113	2025-06-16 23:39:11.926884	2025-06-18 00:00:00
24	15	Тестовый счет	32113	2025-06-16 23:52:21.046813	2025-06-18 00:00:00
25	15	Тестовый счет	32113	2025-06-16 23:52:22.89285	2025-06-18 00:00:00
26	15	аыв	32113	2025-06-16 23:52:37.894445	2025-06-18 00:00:00
27	15	аыв	32113	2025-06-16 23:52:41.22408	2025-06-18 00:00:00
28	15	аыв	32113	2025-06-16 23:52:41.450183	2025-06-18 00:00:00
29	15	аываыв	ыва	2025-06-16 23:52:48.712962	2025-06-18 00:00:00
30	15	аываыв	ыва	2025-06-17 00:02:51.931381	2025-06-18 00:00:00
31	15	fsfdf	sdf	2025-06-17 00:03:22.370945	2025-06-17 00:00:00
32	15	asdasd	asdasd	2025-06-17 00:03:47.330691	2025-06-18 00:00:00
33	15	asdasd	asdasd	2025-06-17 00:06:59.519982	2025-06-18 09:00:00
34	15	Гусев Анатолий Михайлович	32113	2025-06-17 00:08:26.269851	2025-06-26 09:00:00
35	15	Тестовый счет	1233	2025-06-17 00:36:25.659631	2025-06-17 09:00:00
36	15	sdfsdf	sdff	2025-06-17 00:36:35.182614	2025-06-17 09:00:00
\.


--
-- TOC entry 4927 (class 0 OID 16450)
-- Dependencies: 221
-- Data for Name: Transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaction" (id, account_id, user_id, category_id, is_income, transaction_date, amount, transaction_name) FROM stdin;
1	1	1	1	f	2024-11-01 00:00:00	0.00	\N
2	2	2	2	f	2024-11-02 00:00:00	0.00	\N
4	4	4	4	f	2024-11-04 00:00:00	0.00	\N
5	5	5	5	t	2024-11-05 00:00:00	0.00	\N
6	6	6	6	t	2024-11-06 00:00:00	0.00	\N
7	7	7	7	f	2024-11-07 00:00:00	0.00	\N
8	8	8	8	f	2024-11-08 00:00:00	0.00	\N
9	9	9	9	t	2024-11-09 00:00:00	0.00	\N
10	10	10	10	f	2024-11-10 00:00:00	0.00	\N
11	1	1	2	t	2024-11-11 00:00:00	0.00	\N
14	4	4	5	f	2024-11-14 00:00:00	0.00	\N
15	5	5	6	t	2024-11-15 00:00:00	0.00	\N
16	6	6	7	f	2024-11-16 00:00:00	0.00	\N
17	7	7	8	f	2024-11-17 00:00:00	0.00	\N
18	8	8	9	t	2024-11-18 00:00:00	0.00	\N
19	9	9	10	f	2024-11-19 00:00:00	0.00	\N
20	10	10	1	t	2024-11-20 00:00:00	0.00	\N
12	2	2	\N	t	2024-11-12 00:00:00	0.00	\N
23	15	15	1	t	2025-05-26 03:09:10.751347	34111.00	fsdfsdf
24	15	15	1	t	2025-05-26 03:16:39.527085	14234.14	fsdfsdfsd
25	15	15	1	t	2025-05-26 03:16:42.726347	14234.14	fsdfsdfsd
26	15	15	1	t	2025-05-26 03:18:16.987189	312333.00	Анатолий
27	15	15	1	t	2025-05-26 03:19:25.430003	1424.00	Расход
29	15	15	1	t	2025-05-26 03:21:25.3012	124144.00	Гусев Анатолий Михайлович
31	19	15	1	t	2025-05-26 03:36:56.95932	1244.00	Гусев Анатолий Михайлович
32	19	15	1	t	2025-05-26 03:38:14.396773	4532424.00	Тестовый счет3
40	15	15	1	f	2025-05-26 04:07:57.392731	14233.00	fsdfsdf
41	15	15	1	f	2025-05-26 04:09:46.764871	1233.00	Siffer
42	15	15	1	f	2025-05-26 04:15:07.835857	123333.00	fsdfsdf
47	15	15	1	t	2025-05-26 09:01:56.072327	2344.00	Счет 1
48	15	15	1	f	2025-05-26 09:05:16.275671	1234312.00	Авыва
55	28	18	1	t	2025-05-26 10:38:03.378308	9344.34	Операция 1
56	28	18	1	f	2025-05-26 10:38:21.086442	3243.34	Операция 2
60	15	15	1	t	2025-06-01 14:34:48.635237	3123.00	Тестовый счет
64	34	15	1	t	2025-06-01 16:31:33.881506	1243213.00	fsdfsdf
69	15	15	27	t	2025-06-09 02:10:14.523991	284003.00	ЗП
71	15	15	25	f	2025-06-09 02:13:39.970182	1543.00	Мак
68	15	15	\N	t	2025-06-09 01:55:52.166183	3444.00	Аренда
73	15	15	22	f	2025-06-14 19:29:47.855166	3243.00	МакДоставка
81	15	15	26	f	2025-06-15 12:45:07.012999	56200.00	Глобальные
82	15	15	27	t	2025-06-16 18:57:44.019357	43200.00	Тестовая операций 13
83	40	15	27	t	2025-06-16 21:34:30.161019	0.07	Фрик
\.


--
-- TOC entry 4929 (class 0 OID 16456)
-- Dependencies: 223
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
15	Гусев	Анатолий		g1@mail.ru	123123	2002-03-15	2025-05-26 01:40:19.135056	1
16	Гусев Анатолий Михайлович	Анатолий		g2@mail.ru	123123	2011-11-11	2025-05-26 01:45:14.957572	1
17	Андрей	Сидоров		gt1@mail.ru	123123	2002-04-11	2025-05-26 10:07:02.859939	1
18	Андрей	Фикс		gt2@mail.ru	123123	2003-04-04	2025-05-26 10:37:16.235464	1
20	Анатолий	Гусев		g3@mail.ru	123123	2003-03-15	2025-06-16 15:56:31.427008	1
\.


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 216
-- Name: Account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Account_id_seq"', 40, true);


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 218
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 29, true);


--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 220
-- Name: Note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Note_id_seq"', 36, true);


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 222
-- Name: Transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaction_id_seq"', 83, true);


--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 224
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 20, true);


--
-- TOC entry 4760 (class 2606 OID 16469)
-- Name: Account Account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY (id);


--
-- TOC entry 4762 (class 2606 OID 16471)
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- TOC entry 4764 (class 2606 OID 16473)
-- Name: Note Note_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_pkey" PRIMARY KEY (id);


--
-- TOC entry 4766 (class 2606 OID 16475)
-- Name: Transaction Transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_pkey" PRIMARY KEY (id);


--
-- TOC entry 4768 (class 2606 OID 16477)
-- Name: User User_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);


--
-- TOC entry 4770 (class 2606 OID 16479)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 4777 (class 2620 OID 16480)
-- Name: Transaction transaction_account_balance_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER transaction_account_balance_update AFTER INSERT ON public."Transaction" FOR EACH ROW EXECUTE FUNCTION public.update_account_balance();


--
-- TOC entry 4771 (class 2606 OID 16481)
-- Name: Account Account_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES public."User"(id) ON DELETE CASCADE;


--
-- TOC entry 4772 (class 2606 OID 16486)
-- Name: Category Category_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON DELETE CASCADE;


--
-- TOC entry 4773 (class 2606 OID 16491)
-- Name: Note Note_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON DELETE CASCADE;


--
-- TOC entry 4774 (class 2606 OID 16496)
-- Name: Transaction Transaction_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_account_id_fkey" FOREIGN KEY (account_id) REFERENCES public."Account"(id) ON DELETE CASCADE;


--
-- TOC entry 4775 (class 2606 OID 16501)
-- Name: Transaction Transaction_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."Category"(id) ON DELETE SET NULL;


--
-- TOC entry 4776 (class 2606 OID 16506)
-- Name: Transaction Transaction_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON DELETE CASCADE;


-- Completed on 2025-06-23 03:56:55

--
-- PostgreSQL database dump complete
--

