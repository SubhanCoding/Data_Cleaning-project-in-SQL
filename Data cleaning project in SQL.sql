create database	cleaning;
use cleaning;

alter table 1111_messy_dataset
Rename to transaction;

select * from transaction;

-- 1. Fill missing email with a placrholder
       SET SQL_SAFE_UPDATES = 0;
       update transaction
       set email='Unknown@gmail.com' where email = '';
       
-- 2. Identify and remove duplicates value based on phone numbers     
	  delete from transaction 
      where transactionId not in(
       select * from(
        select min(transactionID)from transaction
        group by phoneNumber 
       )as temp_table    );
       
-- 3. Fix email format issue (Domain missing)      
		update transaction 
        set email = concat(email,'.com')
        where email not like '%.com';
        
        
-- 4. Standerized payment method        

		update transaction 
        set PaymentMethod='Credit Card' where PaymentMethod ='%Card';
        
        
-- 5.    Remaove failed transaction from dataset     
				Delete from transaction where Status ='Failed';
                
--  6. Replace negative purchase amount with null.alter         
				Update transaction 
                set purchaseAmount = Null
                where  purchaseAmount < 0;
                
 select * from transaction;
--  7.capitalize the first letter

      update transaction 
     set CustomerName = concat(upper(left(CustomerName,1)), lower(substring(CustomerName,2)))
     where CustomerName is not null;
