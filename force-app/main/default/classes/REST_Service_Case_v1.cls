@RestResource(urlMapping='/v1/case/*')
global with sharing class REST_Service_Case_v1 {
  @HttpPost
  global static Case createCase(Case c) {
    insert c;

    ICasesSelector casesSelector = (ICasesSelector) Application.Selector.newInstance(
      Case.SObjectType
    );
    return casesSelector.selectById(c.Id);
  }

  @HttpGet
  global static Case getCase() {
    RestRequest req = RestContext.request;

    Id caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

    ICasesSelector casesSelector = (ICasesSelector) Application.Selector.newInstance(
      Case.SObjectType
    );

    return casesSelector.selectById(caseId);
  }
}
