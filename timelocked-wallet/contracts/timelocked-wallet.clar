;; FIRST clarinet new timelocked-wallet
;; SECOND clarinet contract new timelocked-wallet


;; timelocked-wallet
;; TODO smart contract to unlock a certain amount of STX tokens after a specified block height

;; TALK contracts should be as easy to read and maintainble as possible
;; so we will make use of constants to define the contract owner and various error states

;; constants
;; Owner
(define-constant contract-owner tx-sender) ;; REMEMBER tx-sender is a Clarity keyword that contains the principal that send the tx and can be contract principal through used of as-contract function

;; Errors
;; somone other than contract owner called lock
(define-constant err-owner-only (err u100))
;; contract owner tried to call lock more than once
(define-constant err-already-locked (err u101))
;; the unlock height given is in the past
(define-constant err-unlock-in-past (err u102))
;; owner called lock with an initial deposit of zero
(define-constant err-no-value (err u103))
;; somebody other that the beneficiary called claim or lock
(define-constant err-beneficiary-only (err u104))
;; the beneficiary called claim but the unlock height hasn't been reached
(define-constant err-unlock-height-not-reached (err u105))

;; data maps and vars
;; beneficiary will be an optional principal to account for the uninitialised state of the contract before the owner calls lock
(define-data-var beneficiary (optional principal) none)
;; unlock height
(define-data-var unlock-height uint u0)

;; private functions
;;

;; public functions
;; lock takes the principal, unlock height, and an initial deposit amt
(define-public (lock (new-beneficiary principal) (unlock-at uint) (amount uint))
  (begin
    ;; only the contract owner may call lock asserts! take bool and throw value, if the bool is true it continues, if not it stops execution
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    ;; the wallet cannot be locked twice in-none will return true if none and false if some, if beneficiary is some we know lock has been called
    (asserts! (is-none (var-get beneficiary)) err-already-locked)
    ;; the unlock height has to be in the future so larger than the current block-height
    (asserts! (> unlock-at block-height) err-unlock-in-past)
    ;; the initial depost must be larger than zero and be successful
    (asserts! (> amount u0) err-no-value)
    ;; set beneficiary some returns true is there is an input value
    (var-set beneficiary (some new-beneficiary))
    ;; set unlock height
    (var-set unlock-height unlock-at)
    ;; try! will attempt to unwrap a value, if value is none or error it will exit. as-contract changes the context to the contract principal so that the contract is the recipient of stx-transfer?
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
    ;; ok true confirms the function completed
    (ok true)
  )
)

;; bestow allows the beneficiary to transfer the right to claim the wallet to another principal
;; upon error: use of potentially unchecked data
(define-public (bestow (new-beneficiary principal))
  (begin
    ;; check that tx-sender is the beneficiary since only beneficiary can change the receiver
    ;; because beneficiary is stored as an optional principal we use some to wrap tx-sender / some returns true if value exists
    (asserts! (is-eq (some tx-sender) (var-get beneficiary)) err-beneficiary-only)
    ;; if current beneficiary called this function, it will set the beneficiary to the principal passed in
    (var-set beneficiary (some new-beneficiary))
    (ok true)
  )
)

;; claim transfers the tokens to tx-sender ONLY if unlock height is reached and tx-sender = beneficiary
(define-public (claim)
  (begin
    ;; check that the sender is the current beneficiary
    (asserts! (is-eq (some tx-sender) (var-get beneficiary)) err-beneficiary-only)
    ;; check that the block height has been reached
    (asserts! (>= block-height (var-get unlock-height)) err-unlock-height-not-reached)
    ;; as-contract switched context of tx-sender to contract principal
    ;; stx-transfer debits the tx-sender and deposits tokens to recipient (in this case beneficiary)
    ;; stx-get-balance gets the balance of sender
    ;; unwrap-panic takes an optional and if it fails to unwrap it (meaning none) it throws a runtime error
    (as-contract (stx-transfer? (stx-get-balance tx-sender) tx-sender (unwrap-panic (var-get beneficiary))))
  )
)

;; TESTING manually

;; wallet will be locked with beneficiary the wallet_1 with a block height of 10 (since console always starts at 0) and a deposit of 100 mSTX
;; (contract-call? .timelocked-wallet lock 'wallet_1_address u10 u100)

;; confirm transfer
;; ::get_assets_maps

;; assume identity for beneficiary so that we can claim
;; ::set_tx_sender wallet_1

;; since we are no longer the contract owner we run the contract call with the contract principal
;; should give us error for unreached block height
;; (contract-call? 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE.timelocked-wallet claim)

;; block height does not increment by itself in console so we can simulate it
;; ::advance_chain_tip 10

;; try to claim again
;; (contract-call? 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE.timelocked-wallet claim)

;; confirm tx
;; ::get_assets_maps