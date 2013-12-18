import numpy as np
from sklearn.multiclass import OneVsRestClassifier
from sklearn.svm import LinearSVC
from sklearn.metrics import accuracy_score
from sklearn import cross_validation

def write_csv(file_path, city_predicted, country_predicted):
	with open(file_path,"w") as f:
		numSamples = city_predicted.shape[0]
		for i in range(numSamples):
			f.write(str(city_predicted[i]) + "," + str(country_predicted[i]) + "\n")

training = np.loadtxt(open("02_data/training.csv","rb"),delimiter=",",usecols=(1,2),dtype="int")
X  = np.loadtxt(open("02_data/X.csv","rb"),delimiter=",")
Y_country = training[:,1]
Y_city = training[:,0]
print("training: shape: " + str(X.shape))


# Cross validation
X_train, X_test, Y_train, Y_test = cross_validation.train_test_split(X, training, test_size=0.3, random_state=0)
accuracy_best = 0
c_country_best = 0
for c in np.linspace(0.001, 0.5, 50):
	svmCountryModel = OneVsRestClassifier(LinearSVC(random_state=0, C=c)).fit(X_train, Y_train[:,1])
	Y_test_predicted = svmCountryModel.predict(X_test);
	accuracy = accuracy_score(Y_test[:, 1], Y_test_predicted)
	
	if accuracy > accuracy_best:
		accuracy_best = accuracy
		c_country_best = c
		print("Accuracy Country: " + str(accuracy_best) + " C: " + str(c_country_best))

accuracy_best = 0
c_city_best = c_country_best
# for c in np.linspace(0.001, 0.5, 50):
# 	svmCountryModel = OneVsRestClassifier(LinearSVC(random_state=0, C=c)).fit(X_train, Y_train[:,0])
# 	Y_test_predicted = svmCountryModel.predict(X_test);
# 	accuracy = accuracy_score(Y_test[:, 0], Y_test_predicted)
#  	
# 	if accuracy > accuracy_best:
# 		accuracy_best = accuracy
# 		c_city_best = c
# 		print("Accuracy City: " + str(accuracy_best) + " C: " + str(c_city_best))

# Train with best parameters
svmCountryModel = OneVsRestClassifier(LinearSVC(random_state=0, C=c_country_best)).fit(X, Y_country)
Y_country_predicted = svmCountryModel.predict(X);
print("training: country accuracy: " + str(accuracy_score(Y_country, Y_country_predicted)))

svmCityModel = OneVsRestClassifier(LinearSVC(random_state=0, C=c_city_best)).fit(X, Y_city) 
Y_city_predicted = svmCityModel.predict(X)
print("training: city accuracy: " + str(accuracy_score(Y_city, Y_city_predicted)))


Xval = np.loadtxt(open("02_data/X-val.csv","rb"),delimiter=",")
Yval_country_predicted = svmCountryModel.predict(Xval);
Yval_city_predicted = svmCityModel.predict(Xval)

write_csv("02_data/Yval_predicted.txt", Yval_city_predicted, Yval_country_predicted)
print "validation predicted"

Xtest = np.loadtxt(open("02_data/X-test.csv","rb"),delimiter=",")
Ytest_country_predicted = svmCountryModel.predict(Xtest);
Ytest_city_predicted = svmCityModel.predict(Xtest)

write_csv("02_data/Ytest_predicted.txt", Ytest_city_predicted, Ytest_country_predicted)
print "test predicted"
