const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.updateAverageRating = functions.firestore
  .document("products/{productId}/reviews/{reviewId}")
  .onWrite(async (change, context) => {
    const productId = context.params.productId;
    const productRef = admin.firestore().collection("products").doc(productId);

    const reviewsSnapshot = await admin.firestore().collection("reviews").get();
    const reviewsCount = reviewsSnapshot.size;

    if (reviewsCount === 0) {
      return productRef.update({ averageRating: 0, reviewsCount: 0 });
    }

    let totalRating = 0;
    reviewsSnapshot.forEach((doc) => {
      totalRating += doc.data().rating;
    });

    const averageRating = totalRating / reviewsCount;

    return productRef.update({ averageRating, reviewsCount });
  });
