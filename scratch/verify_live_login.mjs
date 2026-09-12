async function checkLiveLogin() {
  console.log('Checking live https://askexpert-v2.vercel.app/login.html ...');
  const res = await fetch('https://askexpert-v2.vercel.app/login.html');
  console.log('HTTP Status:', res.status);
  const text = await res.text();
  const title = text.match(/<title>([^<]+)<\/title>/i)?.[1];
  console.log('Title:', title);
  console.log('Checks:');
  console.log('- alreadySignedInBox:', text.includes('id="alreadySignedInBox"'));
  console.log('- eyeIcon SVG:', text.includes('id="eyeIcon"'));
  console.log('- Email or Username placeholder:', text.includes('placeholder="Email or Username"'));
  console.log('- Semantic Register Link:', text.includes('href="register.html"'));
  console.log('- Double-submit protection:', text.includes('isLoggingIn'));
}

checkLiveLogin();
