public with sharing class LoanAssignmentService {
    public LoanAssignmentService() {

    }
     public static void assignAgent(List<Loan_Application__c> loans) {
        if (loans == null || loans.isEmpty()) return;

        List<User> agents = [
    SELECT Id
    FROM User
    WHERE IsActive = true
    AND UserType = 'Standard'
    AND Profile.Name LIKE '%Agent%'
    LIMIT 1
];



        if (agents.isEmpty()) return;

        for (Loan_Application__c loan : loans) {
            if (loan.User__c == null) {
                loan.User__c = agents[0].Id;
            }
        }
    }
}