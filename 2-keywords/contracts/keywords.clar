;; block-height
;; Reflects the current block height of the Stacks blockchain
block-height

;; burn-block-height
;; Reflects the current block height of the underlying burn blockchain (in this case Bitcoin)
burn-block-height

;; tx-sender
;; Contains the principal that sent the transaction
tx-sender

;; as-contract can possibley be used to shift the sending context from actual standard principal to contract principal
(as-contract tx-sender)

;; contract-caller
;; If the contract is called via a signed transaction directly, then tx-sender and contract-caller will be equal
;; If the contract calls another contract in turn, then contract-caller will be equal to the previous contract in the chain.
contract-caller
