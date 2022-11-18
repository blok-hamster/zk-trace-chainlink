// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import {TraceAgreement} from "../traceAgreement.sol";
import {ITraceHub} from "../traceHub.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract TraceAgreementFactory is Ownable{

    address public traceHub;
    constructor(address _traceHub) {
        traceHub = _traceHub;
    }
    
    function newTraceAgreement(bytes32 _verifierRoot, bytes32 _initiatorRoot, bytes32[] calldata _nullifiers, string calldata agreementUri ) public onlyOwner returns(address){
        TraceAgreement _traceAgreement = new TraceAgreement(_verifierRoot, _initiatorRoot,traceHub);

        ITraceHub(traceHub).updatAgreementLog(address(_traceAgreement), agreementUri, _nullifiers);
        return address(_traceAgreement);
    }
}