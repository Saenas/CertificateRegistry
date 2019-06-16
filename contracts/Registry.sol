pragma solidity ^0.5.8;

import './Ownable.sol';

contract Registry is Ownable {
	string public name;

	constructor(string memory _name) public {
		name = _name;
	}	

	event FileRegistered(bytes32 indexed registered);
	event FileRemoved(bytes32 indexed removed);

	struct FileDetails {
		uint timestamp;
		uint blockNumber;
	}

	mapping (bytes32 => FileDetails) registeredFiles;
	mapping (bytes32 => FileDetails) removedFiles;

	function registerFile(bytes32 fileHash) public onlyOwner {
		if (registeredFiles[fileHash].blockNumber == 0) {
			registeredFiles[fileHash].timestamp = now;
			registeredFiles[fileHash].blockNumber = block.number;
			emit FileRegistered(fileHash);
		}
	}

	function removeFile(bytes32 fileHash) public onlyOwner {
		if (removedFiles[fileHash].blockNumber == 0) {
			removedFiles[fileHash].timestamp = now;
			removedFiles[fileHash].blockNumber = block.number;
			emit FileRemoved(fileHash);
		}
	}

	function isRegistered(bytes32 fileHash) public view returns(bool, uint, uint) {
		if (registeredFiles[fileHash].blockNumber != 0) {
			return (true, registeredFiles[fileHash].timestamp, registeredFiles[fileHash].blockNumber);
		}
		return (false, 0, 0);
	}

	function isRemoved(bytes32 fileHash) public view returns(bool, uint, uint){
		if (removedFiles[fileHash].blockNumber != 0) {
			return (true, removedFiles[fileHash].timestamp, removedFiles[fileHash].blockNumber);
		}
		return (false, 0, 0);
	}

	function isValid(bytes32 fileHash) public view returns(bool) {
		return (registeredFiles[fileHash].blockNumber < removedFiles[fileHash].blockNumber);
	}
}