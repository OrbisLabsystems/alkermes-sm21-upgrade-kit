  SELECT SAMP_TMPL_HEADER.[IDENTITY],   
         SAMP_TMPL_HEADER.[DESCRIPTION],   
         SAMP_TMPL_HEADER.MODIFIED_ON,   
         SAMP_TMPL_HEADER.MODIFIED_BY,   
         SAMP_TMPL_HEADER.MODIFIABLE,   
         SAMP_TMPL_HEADER.REMOVEFLAG,   
         SAMP_TMPL_HEADER.GROUP_ID,   
         SAMP_TMPL_HEADER.LOGIN_TITLE,   
         SAMP_TMPL_HEADER.SAMPLE_STATUS,   
         SAMP_TMPL_HEADER.SYNTAX_ID,   
         SAMP_TMPL_HEADER.EDIT_TESTS,   
         SAMP_TMPL_HEADER.TEST_ASSIGNMENT,   
         SAMP_TMPL_HEADER.RECEIPT_ACTION,   
         SAMP_TMPL_HEADER.LABEL_ACTION,   
         SAMP_TMPL_HEADER.WSHT_ACTION,   
         SAMP_TMPL_HEADER.LABEL_ID,   
         SAMP_TMPL_HEADER.RECEIPT_ID,   
         SAMP_TMPL_HEADER.WSHT_ID,   
         SAMP_TMPL_HEADER.LABEL_PRINTER,   
         SAMP_TMPL_HEADER.RECEIPT_PRINTER,   
         SAMP_TMPL_HEADER.WSHT_PRINTER,   
         SAMP_TMPL_HEADER.AUTO_WKS,   
         SAMP_TMPL_HEADER.ACTION_TYPE,   
         SAMP_TMPL_HEADER.SUPERTEMPLATE  
    FROM SAMP_TMPL_HEADER
   	ORDER BY [IDENTITY];