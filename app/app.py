from flask import Flask, request, render_template, redirect, url_for 
app = Flask(__name__, static_url_path='/static')

@app.route('/')
def home():
    return render_template('home.html') 

@app.route('/whr/')
def whr():
    return render_template('WorldHappinessbyRank.html') 

@app.route('/check/')
def check():
    return render_template('check_family.html') 

@app.route('/hsyears/')
def hsyears():
    return render_template('hs4_years.html') 

@app.route('/hsregion/')
def hsregion():
    return render_template('hs_region.html')

@app.route('/hshtmp/')
def hshtmp():
    return render_template('hs_htmap.html') 

@app.route('/fctrsdst/')
def fctrsdst():
    return render_template('fctrs_dst.html')

@app.route('/fctrsdstp5/')
def fctrsdstp5():
    return render_template('fctrs_top5.html') 

@app.route('/fctrsdstrg/')
def fctrsdstrg():
    return render_template('fctrs_region.html')

@app.route('/incshare/')
def incshare():
    return render_template('income_share.html')

@app.route('/incshareL/')
def incshareL():
    return render_template('IncomeShareByTheLowest.html')

@app.route('/incshareH/')
def incshareH():
    return render_template('ISLowest_htmap.html')

@app.route('/about/')
def about():
    return render_template('about.html')
    
if __name__ == "__main__":
     app.run(debug=True)











