document.querySelector('.host-form').addEventListener('submit', function() {
  var form = this;

  event.preventDefault();

  chargify.token(
      form,

      function success(token) {
          console.log('{host} token SUCCESS - token: ', token);

          // host will write token in hidden input
          document.querySelector('#host-token').value = token;

          // and then submit form
          // form.submit();
          console.log('{host} form submitted');
      },
      function error(err) {
          console.log('{host} token ERROR - err: ', err);
      }
  );
});
