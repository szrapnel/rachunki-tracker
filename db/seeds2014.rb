Operator.find_or_create_by(id: 1, name: 'T-mobile K', days_between_invoices: 30)
Operator.find_or_create_by(id: 2, name: 'T-mobile S', days_between_invoices: 30)
Operator.find_or_create_by(id: 3, name: 'Orange st', days_between_invoices: 30)
Operator.find_or_create_by(id: 4, name: 'Orange NET', days_between_invoices: 30)
Operator.find_or_create_by(id: 5, name: 'Czynsz', days_between_invoices: 30)

Invoice.find_or_create_by(operator_id: 1, title: 'I', due_date: '08-02-2014')
Invoice.find_or_create_by(operator_id: 2, title: 'I', due_date: '')
Invoice.find_or_create_by(operator_id: 3, title: 'I', due_date: '18-08-2014')
Invoice.find_or_create_by(operator_id: 4, title: 'I', due_date: '')
Invoice.find_or_create_by(operator_id: 5, title: 'I', due_date: '15-01-2014')