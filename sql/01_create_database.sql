/* ============================================================================
   Project:  Ecuador Customs Tax Collection (SENAE), 2021-2026
   Purpose:  Create the PostgreSQL database used by the project.
   Notes:    CREATE DATABASE cannot run inside a transaction block, so it
             lives in its own file. The script fails if the database exists.
   Author:   Sebastián Velasteguí
   ============================================================================ */
 
CREATE DATABASE foreign_trade_senae;
