import Foundation

class Script: Component {

	// MARK: - To Override

	func publishSignals(publisher: SignalPublisher) {
	}
}

// TODO: Actually, RenderScript was actually needed to implement lazy data update propogation, otherwise
// we should check for this always in update(). Whole idea with scripts and state was about laziness so
// we don't have to check everything everytime. Messages wake up runloop to deliver them to scripts, scripts
// will update the state of components, which will cause new wave of messages to render's script which will
// update the state and 
