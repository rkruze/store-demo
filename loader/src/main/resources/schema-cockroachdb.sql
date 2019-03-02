DROP TABLE IF EXISTS ACCT CASCADE;

CREATE TABLE IF NOT EXISTS ACCT
(
  ACCT_NBR         STRING(25)     NOT NULL,
  ACCT_TYPE_IND    CHAR(2)        NOT NULL,
  ACCT_BAL_AMT     DECIMAL(18, 4) NOT NULL,
  ACCT_STAT_CD     DECIMAL(2, 0)  NOT NULL,
  EXPIR_DT         DATE      DEFAULT NULL,
  CRT_TS           TIMESTAMP      NOT NULL,
  LAST_UPD_TS      TIMESTAMP DEFAULT NULL,
  LAST_UPD_USER_ID STRING(8) DEFAULT NULL,
  ACTVT_INQ_TS     TIMESTAMP DEFAULT NULL,
  STATE            STRING(2)      NOT NULL,
  CONSTRAINT "primary" PRIMARY KEY (STATE ASC, ACCT_NBR ASC)
);

ALTER TABLE ACCT PARTITION BY LIST (STATE) (PARTITION east VALUES IN ('VA'), PARTITION central VALUES IN ('TX'), PARTITION west VALUES IN ('CA'));
ALTER PARTITION east OF TABLE ACCT CONFIGURE ZONE USING constraints='[+region=us-east1]';
ALTER PARTITION central OF TABLE ACCT CONFIGURE ZONE USING constraints='[+region=southcentralus]';
ALTER PARTITION west OF TABLE ACCT CONFIGURE ZONE USING constraints='[+region=us-west2]';

DROP TABLE IF EXISTS AUTH CASCADE;

CREATE TABLE IF NOT EXISTS AUTH
(
  ACCT_NBR         STRING(25)     NOT NULL,
  REQUEST_ID       UUID           NOT NULL,
  AUTH_ID          STRING(64)     NOT NULL,
  AUTH_AMT         DECIMAL(18, 4) NOT NULL,
  AUTH_STAT_CD     DECIMAL(2, 0)  NOT NULL,
  CRT_TS           TIMESTAMP      NOT NULL,
  LAST_UPD_TS      TIMESTAMP      NOT NULL,
  LAST_UPD_USER_ID STRING(8)      NOT NULL,
  STATE            STRING(2)      NOT NULL,
  CONSTRAINT "primary" PRIMARY KEY (STATE ASC, ACCT_NBR ASC, REQUEST_ID ASC)
);

ALTER TABLE AUTH PARTITION BY LIST (STATE) (PARTITION east VALUES IN ('VA'), PARTITION central VALUES IN ('TX'), PARTITION west VALUES IN ('CA'));
ALTER PARTITION east OF TABLE AUTH CONFIGURE ZONE USING constraints='[+region=us-east1]';
ALTER PARTITION central OF TABLE AUTH CONFIGURE ZONE USING constraints='[+region=southcentralus]';
ALTER PARTITION west OF TABLE AUTH CONFIGURE ZONE USING constraints='[+region=us-west2]';
