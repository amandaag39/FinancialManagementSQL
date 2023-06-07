USE financialmanagement;
-- Alter table statements
ALTER TABLE exchange_rate
DROP foreign key base_currency_id,
DROP foreign key target_currency_id;
ALTER TABLE exchange_rate
ADD CONSTRAINT base_currency_id_unique UNIQUE (base_currency_id),
ADD CONSTRAINT target_currency_id_unique UNIQUE (target_currency_id);
ALTER TABLE exchange_rate
ADD CONSTRAINT base_currency_id FOREIGN KEY (base_currency_id) REFERENCES currency (currency_id) ON DELETE SET NULL,
ADD CONSTRAINT target_currency_id FOREIGN KEY (target_currency_id) REFERENCES currency (currency_id) ON DELETE SET NULL;
SHOW CREATE TABLE exchange_rate;
SHOW CREATE TABLE transaction_type;
SHOW CREATE TABLE transaction;
ALTER TABLE transaction
DROP FOREIGN KEY transaction_type_id;
ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_transaction_type
FOREIGN KEY (transaction_type_id) REFERENCES transaction_type (transaction_type_id)
ON DELETE CASCADE ON UPDATE CASCADE;
SHOW CREATE TABLE TRANSACTION;
ALTER TABLE `financialmanagement`.`order` 
RENAME TO  `financialmanagement`.`orders` ;
ALTER TABLE holdings ADD COLUMN account_id INT;
ALTER TABLE holdings
ADD CONSTRAINT fk_holdings_account
FOREIGN KEY (account_id) REFERENCES account(account_id);
SHOW CREATE TABLE holdings;
-- Update Statements
UPDATE user
SET password = 'newpasswprd', first_name = 'John', last_name = 'Doe', date_of_birth = '2001-03-02', registration_date = '2023-04-27T13:00', last_login = '2023-05-23'
WHERE user_id = 1;
UPDATE stock
SET exchange = 'NASDAQ-GS', sector = 'Technology', p_e_ratio = '30.58', earnings_per_share = '5.89', dividend_yield = '0.53', volume = '68.81', beta = '1.29'
WHERE stock_symbol = 'AAPL';
UPDATE order_details
SET price = 180950
WHERE order_detail_id = 1;
UPDATE account
SET balance = 500000.00
WHERE account_id = 1;
UPDATE currency
SET currency_name = 'Euro'
WHERE currency_id = 3;
UPDATE holdings
SET quantity = 50
WHERE holding_id = 2;
UPDATE orders
SET price = 25.00
WHERE order_id = 2;
UPDATE order_details
SET price = 150.00, quantity = 5
WHERE order_detail_id = 3;
UPDATE order_details
SET price = 150.00, quantity = 6
WHERE order_detail_id = 2;
UPDATE orders
SET price = 30.00
WHERE order_id = 3;
-- Insert Statements
INSERT INTO account (account_id, user_id, account_type, balance, date_created)
VALUES (1, 1, 'Personal', 10000, '2023-03-23T12:02:23');
INSERT INTO currency (currency_id, currency_code, currency_name, symbol)
VALUES (1, 'USD', 'US Dollar', '$');
INSERT INTO currency (currency_id, currency_code, currency_name, symbol)
VALUES (2, 'JPY', 'Japanese Yen', '円');
INSERT INTO exchange_rate (exchange_rate_id, base_currency_id, target_currency_id, rate)
VALUES (1, 1, 2, 139.946);
INSERT INTO portfolio (portfolio_id, user_id, portfolio_name, date_created)
VALUES (1, 1, 'Technology Portfolio', '2023-06-01');
INSERT INTO holdings (holding_id, portfolio_id, stock_symbol, quantity, purchase_price, purchase_date)
VALUES (1, 1, 'AAPL', 1000, 180.95, '2023-06-01');
INSERT INTO orders (order_id, account_id, stock_symbol, order_type, quantity, price, order_date)
VALUES (1, 1, 'AAPL', 'Market', 1000, 180.95, '2023-06-02');
INSERT INTO order_details (order_detail_id, order_id, stock_symbol, quantity, price)
VALUES (1, 1, 'AAPL', 1000, 180.95);
INSERT INTO payment (payment_id, account_id, amount, currency_id, payment_date)
VALUES (1, 1, 180950.00, 1, '2023-06-01T11:23:01');
INSERT INTO transaction_type (transaction_type_id, transaction_type_name)
VALUES (1, 'Tech Shares'); 
INSERT INTO transaction (transaction_id, account_id, amount, transaction_date, currency_id, transaction_type_id)
VALUES (1, 1, 180950.00, '2023-06-01', 1, 1);
INSERT INTO currency (currency_id)
VALUES (3);
INSERT INTO holdings (holding_id)
VALUES (2);
INSERT INTO orders (order_id)
VALUES (2);
INSERT INTO orders (order_id)
VALUES (3);
INSERT INTO order_details (order_detail_id)
VALUES (2);
INSERT INTO order_details (order_detail_id)
VALUES (3);
INSERT INTO user (user_id, username, email, password, first_name, last_name, date_of_birth, registration_date, last_login)
VALUES (2, 'doe.jane','doe.jane@example.com', 123456, 'Jane', 'Doe', '1982-03-04', '2023-02-24T22:34:23', '2023-02-24T22:34:23');
INSERT INTO user (user_id)
VALUES (3);
INSERT INTO account (account_id, balance)
VALUES (2, 0);
INSERT INTO account (account_id)
VALUES (2);
INSERT INTO transactions (transaction_id, account_id, amount)
VALUES (2, 2, 6300);
-- Delete statements
DELETE FROM user WHERE user_id = 3;
-- Inner join statement
SELECT * 
FROM user
JOIN account ON user.user_id = account.user_id;
-- Left join / "Left Outer" join statement
SELECT *
FROM account
LEFT JOIN user ON account.user_id = user.user_id;
-- Right join / "Right Outer" join statement
SELECT user.username, account.balance
FROM user
RIGHT JOIN account ON user.user_id = account.user_id;
-- Full Outer join / Full join statement (using UNION b/c MySQL)
SELECT *
FROM account
LEFT JOIN user ON account.user_id = user.user_id
UNION
SELECT *
FROM account
RIGHT join user ON account.user_id = user.user_id;
-- Big join statment
SELECT *
FROM account
JOIN user ON account.user_id = user.user_id
JOIN currency on account.currency_id = currency.id
JOIN exchange_rate ON currency.currency_id = exchange_rate.base_currency_id
JOIN holdings ON account.account_id = holdings.account_id
JOIN portfolio ON holdings.portfolio_id = portfolio.portfolio_id
JOIN stock ON holdings.stock_symbol = stock.stock_symbol
JOIN orders ON account.account_id = orders.account_id
JOIN payment ON account.account_id = payment.account_id
JOIN transactions ON account.account_id = transactions.account_id
JOIN transaction_type ON transactions.transaction_type_id = transaction_type.transaction_type_id;
-- Agg functions w/o having
SELECT account_id, count(order_id) AS order_count
FROM orders
GROUP BY account_id;
-- Aggregate functions w/ habving
SELECT price, COUNT(*) AS price_count
FROM orders
GROUP BY price
HAVING COUNT(*) = 1;
