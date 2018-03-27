import turicreate as turi
url = "dataset/"

#load images from dataset
data = turi.image_analysis.load_images(url)

#define the image
data["damageType"] = data["path"].apply(lambda path: "scratches" if "scratches" in path else "dents" if "dents" in path else "chips" if "chips" in path else "noDamage" if "noDamage" in path else "largeDamage" if "largeDamage" in path else "curbRash")

data.save("damage.sframe")

data.explore()



dataBuffer = turi.SFrame("damage.sframe")


trainingBuffers, testingBuffers = dataBuffer.random_split(0.9)

model = turi.image_classifier.create(trainingBuffers, target="damageType", model="squeezenet_v1.1")

evaluations = model.evaluate(testingBuffers)
print (evaluations["accuracy"])


model.save("damage.model")
model.export_coreml("damageClassifier.mlmodel")
