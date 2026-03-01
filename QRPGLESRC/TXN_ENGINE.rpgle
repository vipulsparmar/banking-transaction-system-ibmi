      **free
      //---------------------------------------------------------
      // Banking Transaction Engine
      // Processes Deposits and Withdrawals for a given AccountID
      //---------------------------------------------------------
      ctl-opt dftactgrp(*no) actgrp(*new) option(*nodebugio);

      dcl-f ACCOUNTS usage(*update) keyed;
      dcl-f TRANSACT usage(*output) keyed;

      dcl-pi MAIN;
        pAcctID   char(10);
        pTxnType  char(1); // 'D' for Deposit, 'W' for Withdrawal
        pAmount   packed(13:2);
      end-pi;

      dcl-s errorMsg varchar(50);
      dcl-s nextTxnID char(10);

      // Perform transaction
      chain pAcctID ACCOUNTS;

      if %found(ACCOUNTS);
        // Record locking in place due to chain on *update file
        if pTxnType = 'D'; // Deposit
          BALANCE += pAmount;
          update RACCT;
          writeTxnRecord(pAcctID: pTxnType: pAmount);
        elseif pTxnType = 'W'; // Withdrawal
          if BALANCE >= pAmount;
            BALANCE -= pAmount;
            update RACCT;
            writeTxnRecord(pAcctID: pTxnType: pAmount);
          else;
            errorMsg = 'Insufficient funds for account ' + pAcctID;
            dsply errorMsg;
          endif;
        endif;

      else;
        errorMsg = 'Account Not Found: ' + pAcctID;
        dsply errorMsg;
      endif;

      *inlr = *on;

      //---------------------------------------------------------
      // Internal Subprocedure to record the transaction
      //---------------------------------------------------------
      dcl-proc writeTxnRecord;
        dcl-pi *n;
          acctID  char(10);
          txnType char(1);
          amount  packed(13:2);
        end-pi;

        // Simplified TxnID generation using a timestamp + random 
        TXNID = %subst(%char(%timestamp()): 1: 10);
        ACCTID = acctID;
        TXNTYPE = txnType;
        AMOUNT = amount;
        TXNTIME = %time();
        write RTNX;
      end-proc;
