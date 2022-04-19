import { useState, useEffect } from "react";
import Head from "next/head";

export default function Home() {
  const [post, setPost] = useState("");
  const [price, setPrice] = useState(1);
  const [userData, setUserData] = useState({});
  const [loggedIn, setLoggedIn] = useState(false);

  const handlePostChange = (e) => {
    setPost(e.target.value);
  };

  const handlePriceChange = (e) => {
    setPrice(e.target.value);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Do Stacks things
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen py-2">
      <Head>
        <title>Blockpost</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className="flex flex-col items-center justify-center w-full flex-1 px-20 text-center">
        <h1 className="text-6xl font-bold mb-24">Blockpost</h1>
        <form onSubmit={handleSubmit}>
          <p>
            Post
            <input
              className="p-6 border rounded mx-2"
              type="text"
              value={post}
              onChange={handlePostChange}
              placeholder="something"
            />
            for
            <input
              className="p-6 border rounded mx-2"
              type="number"
              value={price}
              onChange={handlePriceChange}
            />{" "}
            STX
          </p>
          <button
            type="submit"
            className="p-6 bg-green-500 text-white mt-8 rounded"
          >
            Submit
          </button>
        </form>
      </main>
    </div>
  );
}
