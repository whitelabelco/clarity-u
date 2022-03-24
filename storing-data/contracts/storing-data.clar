
;; storing-data
;; Examples of storing data 

;; constants
;; constant values are unchageable, commonly used to store the principal that deployed the contract and for errors
;; syntax
;; (define-constant constant-name expression)
(define-constant contract-owner tx-sender)
(define-constant err-contract-owner-only u100)

(define-constant my-constant "This is a constant value")
;; allows us to print to the screen in repl
(print my-constant)

;; data maps and vars
;; variables have an initial value and can be changed by future contract calls
;; contain exactly one value of a predefined type
;; syntax
;; (define-data-var var-name var-type initial-value)
(define-data-var my-number uint u0)
;; we can read variables with var-get
(print (var-get my-number))

(define-data-var number-to-change uint u0)
;; we can set varialables with var-set
(var-set number-to-change u1)
(print (var-get number-to-change))

;; maps are collections of data identified by other data similar to tuples, but unlike tuple keys, map keys are not hard-coded
;; syntax
;; (define-map map-name key-type value-type)
;; here we define a map with a name of balances and are telling it that the key will be a principal type and the value will be an uint
(define-map balances principal uint)
;; set the map values with maps-set
(map-set balances tx-sender u500)
;; retrieve the value of tx-sender with map-get
(print (map-get? balances tx-sender))

(define-map balance-to-delete principal uint)
(map-set balance-to-delete tx-sender u500)
;; used to delete entries
(map-delete balance-to-delete tx-sender)
(print (map-get? balance-to-delete tx-sender))

;; private functions
;;

;; public functions
;;
