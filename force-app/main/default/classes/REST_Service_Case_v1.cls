@RestResource(urlMapping='/v1/case/*')
global with sharing class REST_Service_Case_v1 {
  @HttpPost
  global static Case createCase(Case c) {
    insert c;

    ICasesSelector casesSelector = (ICasesSelector) Application.Selector.newInstance(
      Case.SObjectType
    );
    List<Case> result = casesSelector.selectById(new Set<Id>{ c.Id });

    return result.isEmpty() ? null : result.get(0);
  }
}
