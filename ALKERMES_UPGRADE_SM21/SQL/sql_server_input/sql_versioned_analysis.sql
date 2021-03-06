  SELECT VERSIONED_ANALYSIS.[IDENTITY],
         ltrim(VERSIONED_ANALYSIS.ANALYSIS_VERSION),
         VERSIONED_ANALYSIS.GROUP_ID,
         VERSIONED_ANALYSIS.ANALYSIS_TYPE,
         VERSIONED_ANALYSIS.[DESCRIPTION],
         VERSIONED_ANALYSIS.INSTTYPE_ID,
         VERSIONED_ANALYSIS.PREPARATION_ID,
         VERSIONED_ANALYSIS.EXPECTED_TIME,
         VERSIONED_ANALYSIS.CHARGECODE,
         VERSIONED_ANALYSIS.RESULT_SCREEN,
         VERSIONED_ANALYSIS.MODIFIED_ON,
         VERSIONED_ANALYSIS.MODIFIED_BY,
         VERSIONED_ANALYSIS.MODIFIABLE,
         VERSIONED_ANALYSIS.REMOVEFLAG,
         VERSIONED_ANALYSIS.CALCULATION,
         VERSIONED_ANALYSIS.REPLICATES,
         VERSIONED_ANALYSIS.ACCESS_FLAGS,
         VERSIONED_ANALYSIS.COMP_REPLICATES,
         VERSIONED_ANALYSIS.GENERIC_ANALYSIS,
         VERSIONED_ANALYSIS.APPROVAL_REQD,
         VERSIONED_ANALYSIS.ALLOW_CATEGORY,
         VERSIONED_ANALYSIS.APPROVAL_STATUS,
         VERSIONED_ANALYSIS.AUTO_VALIDATE,
         VERSIONED_COMPONENT.ANALYSIS,
         ltrim(VERSIONED_COMPONENT.ANALYSIS_VERSION),
         VERSIONED_COMPONENT.NAME,
         ltrim(VERSIONED_COMPONENT.ORDER_NUMBER),
         VERSIONED_COMPONENT.RESULT_TYPE,
         VERSIONED_COMPONENT.MINIMUM,
         VERSIONED_COMPONENT.MAXIMUM,
         VERSIONED_COMPONENT.TRUE_WORD,
         VERSIONED_COMPONENT.FALSE_WORD,
         VERSIONED_COMPONENT.ALLOWED_CHARACTERS,
         VERSIONED_COMPONENT.CALCULATION,
         VERSIONED_COMPONENT.PLACES,
         VERSIONED_COMPONENT.REP_CONTROL,
         VERSIONED_COMPONENT.REPLICATES,
         VERSIONED_COMPONENT.SIG_FIGS_NUMBER,
         VERSIONED_COMPONENT.SIG_FIGS_ROUNDING,
         VERSIONED_COMPONENT.SIG_FIGS_FILTER,
         VERSIONED_COMPONENT.MINIMUM_PQL,
         VERSIONED_COMPONENT.MAXIMUM_PQL,
         VERSIONED_COMPONENT.PQL_CALCULATION,
         VERSIONED_COMPONENT.FORMULA,
         VERSIONED_COMPONENT.MATRIX_NO,
         VERSIONED_COMPONENT.MATRIX_NAME,
         VERSIONED_COMPONENT.COLUMN_NO,
         VERSIONED_COMPONENT.COLUMN_NAME,
         VERSIONED_COMPONENT.ROW_NO,
         VERSIONED_COMPONENT.ROW_NAME
    FROM VERSIONED_ANALYSIS,
         VERSIONED_COMPONENT
ORDER BY VERSIONED_ANALYSIS.[IDENTITY],
         VERSIONED_ANALYSIS.ANALYSIS_VERSION,
         VERSIONED_COMPONENT.ORDER_NUMBER;