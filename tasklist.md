- [x] Create ID column
- [ ] Fix country column - WIP
- [ ] Fix other_currency column
- [ ] Fix additional_context column
- [ ] Fix state column
- [ ] Fix city column




Will have to create another state table.
-- -- Creates the state table
-- {{ config(
--     materialized='table',
--     alias='d.State'
-- ) }}

-- SELECT 
--     response_id,
--     state