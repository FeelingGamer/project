const Jessica = 6470;
const Rona = 6499;
const Milky = 1000;


const multiStepRsvnFormId = '#multiStepRsvnForm';

const multiStepRsvnformData = {
  cDate: function (dt) {
    let subject = new Date(dt);
    return [subject.getFullYear(), subject.getMonth() + 1, subject.getDate()].join('-');
  },
  d: function () {
    return {
      cid: $('input[name="cid"]').val(),
      start: $('input[name="startDate"]').val(),
      end: $('input[name="endDate"]').val(),
      surpackage: $('select[name="surpackage"]').val(),
      requirement: $('select[name="roomRequirement"]').val(),
      host: $('select[name="host"]').val(),
      popper: $('select[name="popper"]').val(),
      message: $('textarea[name="message"]').val(),
      bookedDate: multiStepRsvnformData.cDate(document.getElementsByClassName('bookedDateTxt')[0].innerHTML),
      numNights: document.getElementsByClassName('numNightsTxt')[0].innerHTML,
      totalPrice: document.getElementsByClassName('totalTxt')[0].innerHTML,
      readySubmit: $('#rsvnNextBtn').attr('readySubmit')
    };
  }
};

// rsvn multi steps
let currentTab = 0;
showTab(currentTab);

function showTab (n) {
  let x = document.getElementsByClassName('rsvnTab');
  x[n].style.display = 'block';
  if (n === 0) {
    document.getElementById('rsvnPrevBtn').style.display = 'none';
  } else {
    document.getElementById('rsvnPrevBtn').style.display = 'inline';
  }
  let rsvnNextBtn = $('#rsvnNextBtn');
  if (n === (x.length - 1)) {
    rsvnNextBtn.text('Submit');
    rsvnNextBtn.attr('readySubmit', 'true');
    rsvnNextBtn.attr('type', 'submit');
    rsvnNextBtn.attr('onclick', 'submitMultiStepRsvn()');
  } else {
    rsvnNextBtn.text('Next');
    rsvnNextBtn.attr('readySubmit', 'false');
    rsvnNextBtn.attr('type', 'button');
    rsvnNextBtn.attr('onclick', 'rsvnNextPrev(1)');
  }
  fixStepIndicator(n);
}

function submitMultiStepRsvn () {
  let canSubmit = document.getElementById('rsvnNextBtn').getAttribute('readySubmit');
  if (!validateRsvnForm() && !canSubmit) {
    return false;
  } else {
    let d = multiStepRsvnformData.d();
    console.log(d);

    $.ajax({
      url: 'app/process_reservation.php',
      type: 'post',
      data: d
    }).done(function (response) {
      try {
        let out = JSON.parse(response);
        if (out.success === 'true') {
          $(multiStepRsvnFormId).prepend(out.response);
          document.getElementById('rsvnNextBtn').disabled = true;
        }
      } catch (string) {
        $(multiStepRsvnFormId).prepend(response);
      }
    });
  }
}

function fixStepIndicator (n) {
  let i;
  let x = document.getElementsByClassName('step');
  for (i = 0; i < x.length; i++) {
    x[i].className = x[i].className.replace(' active', '');
  }
  x[n].className += ' active';
}

function rsvnNextPrev (n) {
  let x = document.getElementsByClassName('rsvnTab');
  if (n === 1 && !validateRsvnForm()) return false;
  x[currentTab].style.display = 'none';
  currentTab = currentTab + n;
  showTab(currentTab);
}

function validateRsvnForm () {
  let tab = document.getElementsByClassName('rsvnTab');
  let valid = true;
  let inputs = tab[currentTab].getElementsByTagName('input');
  for (let i = 0; i < inputs.length; i++) {
    if (inputs[i].hasAttribute('required')) {
      if (inputs[i].value === '') {
        inputs[i].className += ' invalid';
        valid = false;
      }
    }
  }

  let selects = tab[currentTab].getElementsByTagName('select');
  for (let i = 0; i < selects.length; i++) {
    if (selects[i].hasAttribute('required')) {
      if (selects[i].value === '') {
        selects[i].className += ' invalid';
        valid = false;
      }
    }
  }

  if (valid) {
    document.getElementsByClassName('step')[currentTab].className += ' finish';
    new ReservationCost($('select[name="surpackage"]').val(),
      $('input[name="startDate"]').val(),
      $('input[name="endDate"]').val()).displayAll();
  }
  return valid;
}

class ReservationCost {
  constructor (surpackage, startDate, endDate) {
    let today = new Date();
    this.bookDate = today.toDateString();
    this.surpackage = surpackage;
    this.startDate = new Date(startDate);
    this.endDate = new Date(endDate);
  }

  priceByPackageType () {
    if (this.surpackage === 'Jessica') {
      return Jessica;
    }
    if (this.surpackagepe === 'Rona') {
      return Rona;
    }
    if (this.surpackage === 'Milky') {
      return Milky;
    }
  }

  numNights () {
    return new UtilityFunctions().dateDiffInDays(this.startDate, this.endDate);
  }

  displayBookedDate () {
    document.getElementsByClassName('bookedDateTxt')[0].innerHTML = this.bookDate;
  }

  displayRoomPrice () {
    document.getElementsByClassName('roomPriceTxt')[0].innerHTML = '$' + this.numNights() * this.priceByPackageType();
  }

  displayNumNights () {
    document.getElementsByClassName('numNightsTxt')[0].innerHTML = this.numNights().toString();
    document.getElementsByClassName('roomPricePerNightTxt')[0].innerHTML = this.priceByPackageType();
  }

  displayFromTo () {
    let start = this.startDate.getFullYear() + '-' + (this.startDate.getMonth() + 1) + '-' + (this.startDate.getDate() + 1);
    let end = this.endDate.getFullYear() + '-' + (this.endDate.getMonth() + 1) + '-' + (this.endDate.getDate() + 1);
    document.getElementsByClassName('fromToTxt')[0].innerHTML = start + ' to ' + end;
  }

  displayTotalCost () {
    let totalRoomPrice = (this.numNights() * this.priceByPackageType());
    let taxesTxt = document.getElementsByClassName('taxesTxt')[0].innerHTML;
    document.getElementsByClassName('totalTxt')[0].innerHTML = (totalRoomPrice + parseInt(taxesTxt));
  }

  displayAll () {
    this.displayBookedDate();
    this.displayRoomPrice();
    this.displayNumNights();
    this.displayFromTo();
    this.displayTotalCost();
    
  }
}