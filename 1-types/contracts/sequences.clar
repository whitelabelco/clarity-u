;; BUFFERS

;; unstructured data of a fixed maximum length
;; always start with the prefix 0x followed by a hexadecimal string
;; each byte is thus represented by two so-called hexits.
0x68656c6c6f21

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Strings
;; enclosed in double-quotes (")
;; always have a fixed maximum length

;; ASCII
"This is an ASCII string"

;; UTF-8
;; prefinxed by `u`
u"This is an UTF-8 string \u{1f601}"

;; Finding length of the string
(len "How long is this string?") ;; Returns u24

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; LIST

;; they sequences of fixed length that contain another type
;; types cannot mix, a list can only contain items of the same type

(list 4 8 15 16 23 42)
(list "Hello" "World" "!")

;; Length of a list
(len (list "How" "long" "is" "this" "string?")) ;; Returns u5

;; retrieving elements from list
(element-at (list 4 8 15 16 23 42) u3)

;; search an element in the list and get the index
(index-of (list 4 8 15 16 23 42) 23)

;; append element to a list
(append (list 1 2 3 4) 5) ;; Returns (1 2 3 4 5)

;; concatinating 2 lists
(concat (list 1 2) (list 3 4)) ;; Returns (1 2 3 4)

;; filter elements from a list
(filter not (list true false true false)) ;; Returns (false false)

;; iterate over list using `map`
;; map applies an input function to each element and returns a new list with the updated values
(map not (list true true false false)) ;; Returns (list false false true true)


;; iterate over list using `fold`
;; fold applies an input function to each element of the list and the output value of the previous application
;; returns a single result which is the last value returned by the final application.
(fold + (list u1 u2 u3) u0) ;; Returns u6

