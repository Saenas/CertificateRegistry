pragma solidity ^0.5.8;

import './Ownable.sol';

contract Registry is Ownable {
	string public name;

	constructor(string memory _name) public {
		name = _name;
	}	

	event FileRegistered(string indexed registered);
	event FileRemoved(string indexed removed);

	struct FileDetails {
		uint timestamp;
		uint blockNumber;
	}

	mapping (string => FileDetails) registeredFiles;
	mapping (string => FileDetails) removedFiles;

	function registerFile(string memory fileHash) public onlyOwner {
		registeredFiles[fileHash].timestamp = now;
		registeredFiles[fileHash].blockNumber = block.number;
		emit FileRegistered(fileHash);
	}

	function removeFile(string memory fileHash) public onlyOwner {
		removedFiles[fileHash].timestamp = now;
		removedFiles[fileHash].blockNumber = block.number;
		emit FileRemoved(fileHash);
	}

	function isRegistered(string memory fileHash) public view returns(bool, uint, uint) {
		if (registeredFiles[fileHash].blockNumber != 0) {
			return (true, registeredFiles[fileHash].timestamp, registeredFiles[fileHash].blockNumber);
		}
		return (false, 0, 0);
	}

	function isRemoved(string memory fileHash) public view returns(bool, uint, uint){
		if (removedFiles[fileHash].blockNumber != 0) {
			return (true, removedFiles[fileHash].timestamp, removedFiles[fileHash].blockNumber);
		}
		return (false, 0, 0);
	}

	function isValid(string memory fileHash) public view returns(bool) {
		return (registeredFiles[fileHash].blockNumber < removedFiles[fileHash].blockNumber);
	}
}