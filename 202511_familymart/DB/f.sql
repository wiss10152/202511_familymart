-- Table: public."ユーザ情報"

-- DROP TABLE public."ユーザ情報";

CREATE TABLE public."ユーザ情報"
(
  user_name character varying(8) NOT NULL,
  user_id character varying(8) NOT NULL,
  password character(60) NOT NULL,
  admin_flg boolean NOT NULL DEFAULT false,
  delete_flg boolean NOT NULL DEFAULT false,
  create_date timestamp without time zone NOT NULL,
  create_user character varying(8) NOT NULL,
  update_date timestamp without time zone NOT NULL,
  update_user character varying(8) NOT NULL,
  management_flg boolean NOT NULL DEFAULT false,
  CONSTRAINT "ユーザ情報_pkey" PRIMARY KEY (user_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."ユーザ情報"
  OWNER TO postgres;



-- Table: public."出店計画"

-- DROP TABLE public."出店計画";

CREATE TABLE public."出店計画"
(
  "店舗id" character varying(4) NOT NULL,
  "店舗名" text,
  "都道府県" text,
  "出店日" date,
  "住所" text,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT "出店計画_pkey" PRIMARY KEY ("店舗id")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."出店計画"
  OWNER TO postgres;

ALTER TABLE public."出店計画" ADD 店舗オーナー character varying(8);

-- Table: public."商品データ"

-- DROP TABLE public."商品データ";

CREATE TABLE public."商品データ"
(
  "商品コード" character varying(4) NOT NULL,
  "商品名" text,
  "販売会社" text,
  "ジャンル" text,
  "販売日" date,
  "価格" integer,
  "仕入れ値" integer,
  "画像" text,
  CONSTRAINT "商品データ_pkey" PRIMARY KEY ("商品コード")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."商品データ"
  OWNER TO postgres;



-- Table: public."売上データ"

-- DROP TABLE public."売上データ";

CREATE TABLE public."売上データ"
(
  "売上コード" character varying(4) NOT NULL,
  "商品コード" character varying(4),
  "数量" integer,
  "日付" date,
  "店舗id" character varying(4),
  CONSTRAINT "売上データ_pkey" PRIMARY KEY ("売上コード")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."売上データ"
  OWNER TO postgres;



-- Table: public."年俸"

-- DROP TABLE public."年俸";

CREATE TABLE public."年俸"
(
  "氏名" text NOT NULL,
  "店舗id" character varying(4),
  "年俸" integer,
  CONSTRAINT "年俸_pkey" PRIMARY KEY ("氏名")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."年俸"
  OWNER TO postgres;



-- Table: public."経費"

-- DROP TABLE public."経費";

CREATE TABLE public."経費"
(
  "店舗id" character varying(4) NOT NULL,
  "光熱費" integer,
  "テナント料" integer,
  CONSTRAINT "経費_pkey" PRIMARY KEY ("店舗id")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."経費"
  OWNER TO postgres;
