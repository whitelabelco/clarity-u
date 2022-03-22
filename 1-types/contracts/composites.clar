;; OPTIONALS

;; wraps a type and can either be none or a value of that type


;; Example
(element-at (list 4 8 15 16 23 42) u5) ;; Returns 42
(element-at (list 4 8 15 16 23 42) u5000) ;; Returns none

;; TUPLES

;; records that hold multiple values in named fields
{
    id: u5, ;; a uint
    username: "ClarityIsAwesome", ;; an ASCI string
    address: 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE ;; and a principal
}

;; read an element from tuple
(get username { id: 5, username: "ClarityIsAwesome" });; Returns "ClarityIsAwesome"

;; merge merges 2 tuples and forms a new tuple
;; merging is done from left to right and will overwrite values with the same key
(merge
    {id: 5, score: 10, username: "ClarityIsAwesome"}
    {score: 20, winner: true}
) ;; Returns {id: 5, score: 20, username: "ClarityIsAwesome", winner: true}


;; member types can be overwritten by a later tuple in the sequence
(merge
    {id: u6, score: 10}
    {score: u50}
) ;; Returns {id: u6, score: u50}

;; RESPONSES

;; response takes the concrete form of either (ok ...) or (err ...)
(ok true)
(err u5)


