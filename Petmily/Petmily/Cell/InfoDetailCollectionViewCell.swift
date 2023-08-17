import UIKit

class InfoDetailCollectionViewCell: UICollectionViewCell {
    

   @IBOutlet weak var imageLabel: UIImageView!
    
    var image: UIImage?
    
    
    func configure(with image: UIImage?) {
        print(image)
        self.image = image
//        imageLabel.image = validImage
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLabel.image = image
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLabel.image = nil
    }
}
