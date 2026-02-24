import type {NextConfig} from 'next';

const nextConfig: NextConfig = {
  /* config options here */
  devIndicators: false,
  typescript: {
    ignoreBuildErrors: true,
  },
  eslint: {
    ignoreDuringBuilds: true,
  },
  webpack: (config, { isServer }) => {
    if (isServer) {
      // Ignorar face-api.js y tensorflow en el servidor
      config.externals = config.externals || [];
      config.externals.push({
        'face-api.js': 'commonjs face-api.js',
        '@tensorflow/tfjs-node': 'commonjs @tensorflow/tfjs-node',
      });
    }
    
    // Fallbacks para módulos de Node.js que no existen en el navegador
    config.resolve.fallback = {
      ...config.resolve.fallback,
      fs: false,
      encoding: false,
      path: false,
      os: false,
    };
    
    return config;
  },
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'placehold.co',
        port: '',
        pathname: '/**',
      },
      {
        protocol: 'https',
        hostname: 'images.unsplash.com',
        port: '',
        pathname: '/**',
      },
      {
        protocol: 'https',
        hostname: 'picsum.photos',
        port: '',
        pathname: '/**',
      },
    ],
  },
};

export default nextConfig;
