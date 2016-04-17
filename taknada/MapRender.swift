import Foundation
import MapKit

class MapRender: Render {
	override func createView() -> UIView {
		return MKMapView.init()
	}
}
