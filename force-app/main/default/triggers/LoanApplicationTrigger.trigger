trigger LoanApplicationTrigger on Loan_Application__c (before insert) {
    LoanAssignmentService.assignAgent(Trigger.new);
}