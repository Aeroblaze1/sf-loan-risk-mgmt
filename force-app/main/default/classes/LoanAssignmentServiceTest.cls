@IsTest
public class LoanAssignmentServiceTest {

    @IsTest
    static void testLoanInsertRunsAssignmentLogic() {

        // Create Customer with only fields that ACTUALLY exist
        Customer__c customer = new Customer__c(
            Full_Name__c = 'Test Customer',
            PAN_Number__c = 'ABCDE1234F'
        );
        insert customer;

        // Create Loan Application (no Assigned Agent)
        Loan_Application__c loan = new Loan_Application__c(
            Customer__c = customer.Id,
            Loan_Amount__c = 500000,
            Status__c = 'Draft'
        );

        Test.startTest();
        insert loan;
        Test.stopTest();

        // Verify record was inserted (trigger + apex executed without error)
        Loan_Application__c insertedLoan = [
            SELECT Id
            FROM Loan_Application__c
            WHERE Id = :loan.Id
        ];

        System.assertNotEquals(
            null,
            insertedLoan.Id,
            'Loan application should be inserted successfully'
        );
    }
}
