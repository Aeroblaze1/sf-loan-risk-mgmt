# Loan Application Risk & Follow-Up Management System

## Overview

This project is a Salesforce-based Loan Application Risk & Follow-Up Management System designed to simulate real-world workflows used by financial institutions and NBFCs.

The system supports:

- Customer onboarding
- Loan lifecycle tracking
- Automated risk classification
- Agent assignment (Apex-based)
- Conditional approval workflow
- Operational follow-up tracking
- Management dashboards and reporting

The architecture demonstrates both **Salesforce Admin** and **Salesforce Developer** capabilities using a version-controlled Salesforce DX project.

---

## System Architecture

### Custom Objects

#### Customer__c

Stores applicant information.

Key fields:
- Full Name
- Email
- Phone
- PAN Number (validated via REGEX)
- Auto-numbered Customer ID

#### Loan_Application__c

Core business object representing a loan request.

Key fields:
- Loan Amount
- Loan Type
- Status
- Risk Category (auto-calculated)
- Assigned Agent (Lookup to User)
- Lookup to Customer

#### Follow_Up__c

Operational tracking object for post-submission activities.

Key fields:
- Loan Application (Lookup)
- Follow Up Date
- Follow Up Type (Call / Document Request / Reminder / Verification)
- Status (Pending / Completed / Overdue)
- Notes

This object models real operational processes after loan submission.

---

## Business Logic & Automation

### Risk Classification (Flow)

Record-Triggered Flow (Before Save)

Logic:
- Loan Amount ≥ ₹10,00,000 → High Risk
- ₹5,00,000 – ₹9,99,999 → Medium Risk
- < ₹5,00,000 → Low Risk

Ensures automatic and real-time categorization without additional DML operations.

### Agent Assignment (Apex)

Apex Service Class: `LoanAssignmentService.cls`

Trigger: `LoanApplicationTrigger.trigger`

Behavior:
- On loan creation
- Automatically assigns the record creator as default agent
- Bulk-safe implementation
- Clean separation of concerns

Test Class: `LoanAssignmentServiceTest.cls`

### Approval Process

Approval workflow for medium and high-risk loans.

Entry Criteria:
- Status = Submitted
- Risk Category = Medium or High

Workflow Actions:
- On Submission → Status = Under Review
- On Approval → Status = Approved
- On Rejection → Status = Rejected

Low-risk loans bypass approval.

### Operational Follow-Up Automation

After a loan is submitted, a Record-Triggered Flow:
- Automatically creates a Follow Up record
- Default Type: Customer Call
- Default Status: Pending
- Due Date: Today + 2 days

---

## Reporting & Dashboards

Operational reports include:
- Loan Applications by Status
- Loan Applications by Risk Category

Dashboard:
- Loan Pipeline Overview
- Risk Distribution
- Agent Workload

Provides management-level visibility into risk exposure and operational efficiency.

---

## Testing

Apex Test Class: `LoanAssignmentServiceTest.cls`

- Inserts test Customer
- Inserts Loan Application
- Executes trigger logic
- Validates successful record processing

Ensures deployment-safe coverage.

---

## Project Structure

```
force-app/
└── main/
    └── default/
        ├── objects/
        ├── flows/
        ├── classes/
        ├── triggers/
        ├── approvalProcesses/
        ├── validationRules/
        └── dashboards/
```

---

## Deployment

### Authenticate Org

```bash
sf org login web --alias LoanRiskOrg
```

### Deploy Metadata

```bash
sf project deploy start --source-dir force-app
```

### Run Tests

```bash
sf apex run test --class-names LoanAssignmentServiceTest
```

---

## Technologies Used

- Salesforce Lightning Platform
- Apex
- Record-Triggered Flows
- Approval Processes
- Salesforce CLI (`sf`)
- Git & GitHub

---

## Future Enhancements

- Round-robin agent assignment
- Queue-based routing
- SLA tracking and escalation
- Role-based approval routing
- Experience Cloud portal
- Lightning Web Components UI

---

## Author

Built as a Salesforce Developer portfolio project demonstrating:
- Schema design
- Automation strategy
- Apex development
- Approval governance
- Operational modeling
- CLI-based deployment
- Version control discipline
