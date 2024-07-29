import type { AppProps } from 'next/app';
import 'bootstrap/dist/css/bootstrap.min.css';

import '../styles/globals.css';
import '../styles/basic.css';

import React, { useEffect } from 'react';
import Head from 'next/head';

import '../i18n';

function MyApp({ Component, pageProps }: AppProps) {
    return (
        <>
            <Head>
                <meta name="viewport" content="width=device-width, initial-scale=1" />
            </Head>
            <Component {...pageProps} />
        </>
    );
}

export default MyApp;
