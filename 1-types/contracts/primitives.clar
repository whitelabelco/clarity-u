
;; SIGNED INTEGERS

;; `int` is short for signed integer
;; 128 bits numbers that can either be positive or negative
;; Ranges between -2 ^ 127 and (2 ^ 127) - 1

;; Example 5, 10, 0, -200

;; Addition of signed integers
(- 5 10) ;; Returns -5

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; UNSIGNED INTEGERS

;; `uint` is short for unsigned integer
;; 128 bits numbers that can only be positive
;; Ranges between 0 and 2^128 - 1
;; Always prefixed by the character u

;; Example u0, u40935094534, u20

;; Division of unsigned integers
(/ u5 u10) ;; Returns u0

;; Booleans
;; `bool` is short for boolean
;; value can either be true or false 
;; used to check if a certain condition is met or unmet (true or false). 

;; `and` returns true if all conditions are true
(and true true true) ;; Returns true

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; PRINCIPAL

;; represents a Stacks address on the blockchain
;; 2 kinds of principals: standard and contract
;; Standard principals are backed by a corresponding private key
;; Contract principals point to a smart contract
;; Always start with `SP` for the Stacks mainnet and `ST` for the testnet and mocknet

;; Example
;; Standard Principal
'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE
;; Contract principal
'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE.my-awesome-contract

;; Check balance for standard principal
(stx-get-balance 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE)
;; Check balance for contract principal
(stx-get-balance 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE.my-contract)

;; transfer stacks from tx-sender to a standard principal
(stx-transfer? u500 tx-sender 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE)
