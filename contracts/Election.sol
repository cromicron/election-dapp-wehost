pragma solidity 0.8.7;

contract Election {

	// Store accounts that have voted
	mapping(address => bool) public voters;

	// Model a candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}
	// Store Candidates
	// Fetch Candidates
	mapping(uint => Candidate) public candidates;
	// Store Candidates count
	uint public candidatesCount;

	// voted event
	event votedEvent(uint indexed _candidateId);

	// Constructor
	constructor() {
		addCandidate("Chocolate");
		addCandidate("Vanilla");
	}

	function addCandidate(string memory _name) private {
		candidatesCount++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}

	function vote(uint _candidateId) public {

		// require that they haven't voted before
		require(!voters[msg.sender]);

		// require a valid candidate
		require(_candidateId > 0 && _candidateId <= candidatesCount);

		// record that voter has voted
		voters[msg.sender] = true;

		// update candidate vote count
		candidates[_candidateId].voteCount ++;

		// trigger voting event
		emit votedEvent(_candidateId);
	}
}
